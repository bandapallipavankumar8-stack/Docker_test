# 1. Pin to a specific, lightweight version (avoids :latest and reduces OS vulnerabilities)
FROM node:22-alpine3.20

# 2. Set working directory
WORKDIR /app

# 3. Copy dependency files first to leverage Docker layer caching
COPY package*.json ./

# 4. Install only production dependencies cleanly
RUN npm ci --only=production

# 5. Copy the rest of your application source code
COPY . .

# 6. Switch to a built-in non-root user (critical for passing Trivy config scans)
USER node

# 7. Document the port your app listens on
EXPOSE 3000

# 8. Add a healthcheck so orchestrators know if the container is healthy
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1

# 9. Start the application
CMD ["node", "server.js"]
