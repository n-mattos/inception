FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

# Set up the MariaDB configuration
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
