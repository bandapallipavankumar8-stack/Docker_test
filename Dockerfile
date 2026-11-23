FROM alpine:3.22

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

HEALTHCHECK --interval=30s --timeout=3s \
  CMD echo "healthy" || exit 1

CMD ["echo", "Docker security scan test passed!"]
