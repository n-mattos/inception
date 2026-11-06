FROM debian:bookworm

RUN apt-get update && apt-get -y install \
	wget \
	curl \
	bash \
	php8.2 \
	php8.2-curl \
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
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Confirm wp is installed correctly
RUN wp --info

# Expose the port for PHP-FPM
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
