# Dockerfile for AXOMA Webchat Dashboard
# Stage 1: Build stage (if any preprocessing needed - simple static site)
FROM nginx:alpine

# Metadata
LABEL maintainer="Axoma Team <support@axoma.com>"
LABEL description="AXOMA Intelligent Webchat Hub - Electric Powergrid, Airway, Banking & Electricals Dashboard"
LABEL version="1.0.0"

# Install necessary packages (optional - for debugging)
RUN apk add --no-cache curl

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy all static HTML files to nginx web root
COPY index.html /usr/share/nginx/html/
COPY powergrid-chat.html /usr/share/nginx/html/
COPY airway-chat.html /usr/share/nginx/html/
COPY banking-chat.html /usr/share/nginx/html/
COPY electricals-chat.html /usr/share/nginx/html/

# Copy any assets directory if exists (optional)
# COPY assets/ /usr/share/nginx/html/assets/

# Custom nginx configuration for SPA routing (if needed)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Health check to ensure server is running
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]