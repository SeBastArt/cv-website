# Use nginx alpine as base image for serving static content
FROM nginx:alpine

# Set labels for better maintainability
LABEL maintainer="Sebastian Schüler"
LABEL description="Sebastian Schüler Portfolio Website"

# Install curl for health checks. `apk upgrade` first: nginx:alpine lags behind
# Alpine security fixes (2026-11-03: brotli-libs 1.2.0 -> 1.2.1, CRITICAL
# CVE-2026-111497, fixed in the Alpine repo but not yet in nginx:alpine).
RUN apk upgrade --no-cache && apk add --no-cache curl

# Remove default nginx static assets and config
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/default.conf

# Copy website files
COPY index.html /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/
COPY Sebastian_Schüler_Lebenslauf.pdf /usr/share/nginx/html/

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]