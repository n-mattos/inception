#!/bin/sh
set -eu

: "${MYSQL_DATABASE:?MYSQL_DATABASE is required}"
: "${MYSQL_USER:?MYSQL_USER is required}"

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -f /var/lib/mysql/.initialized ]; then
	if [ ! -d /var/lib/mysql/mysql ]; then
		mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
	fi

	socket=/run/mysqld/bootstrap.sock
	mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking \
		--socket="$socket" --pid-file=/run/mysqld/bootstrap.pid --console &
	server_pid=$!

	until mariadb-admin --protocol=socket --socket="$socket" --user=root ping >/dev/null 2>&1; do
		sleep 1
	done

	root_password=$(cat /run/secrets/db_root_password)
	user_password=$(cat /run/secrets/db_user_password)

	mariadb --protocol=socket --socket="$socket" --user=root <<SQL
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$user_password';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_password';
FLUSH PRIVILEGES;
SQL

	MYSQL_PWD="$root_password" mariadb-admin --protocol=socket --socket="$socket" --user=root shutdown
	wait "$server_pid" || true
	touch /var/lib/mysql/.initialized
fi

exec mariadbd --user=mysql --console --bind-address=0.0.0.0
