FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

# Set up the MariaDB configuration
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
