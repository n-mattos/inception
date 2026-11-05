FROM debian:bookworm

RUN apt-get update && apt-get -y install \
	wget \
	curl \
	bash \
	php8.2 \
	php8.2-cgi \
	php8.2-mysql \
	php8.2-fpm \
	php8.2-cli \
	php8.2-mbstring \
	&& rm -rf /var/lib/apt/lists/*

# Set up WordPress CLI (wp-cli)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Copy .conf file
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Confirm wp is installed correctly
RUN wp --info

# Keep the container running with PHP-FPM in the foreground
CMD ["/usr/sbin/php-fpm8.2", "-F"]
