FROM debian:bookworm

RUN apt-get update && apt-get install -y openssl nginx \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=42 Network/OU=nmattos-/CN=nmattos-.42.fr"

# Set environment
ENV NGINX_SSL_KEY=/etc/nginx/ssl/nginx.key
ENV NGINX_SSL_CRT=/etc/nginx/ssl/nginx.crt

# Remove the default nginx configuration
RUN rm -f /etc/nginx/sites-enabled/default
# Copy the custom nginx configuration
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Set up the index.html file (testing purposes)
COPY index.html /usr/share/nginx/html/index.html

# Keep the container running
CMD ["nginx", "-g", "daemon off;"]
