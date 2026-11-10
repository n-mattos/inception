#!/bin/sh
set -eu

# Check that variables are set
: "${MYSQL_DATABASE:?MYSQL_DATABASE is required}"
: "${MYSQL_USER:?MYSQL_USER is required}"

# Create directories
mkdir -p /run/mysqld /var/lib/mysql
# Grant ownership to mysql user (so mariadb can access them)
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Create system tables if missing
if [ ! -d /var/lib/mysql/mysql ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
fi

# Set secrets
root_password=$(cat /run/secrets/db_root_password)
user_password=$(cat /run/secrets/db_user_password)
init_file=/run/mysqld/init.sql

umask 077
# Create initfile with SQL
cat > "$init_file" <<SQL
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%';
ALTER USER '$MYSQL_USER'@'%' IDENTIFIED BY '$user_password';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_password';
FLUSH PRIVILEGES;
SQL

chown mysql:mysql "$init_file"
chmod 600 "$init_file"

# Launch
exec mariadbd --user=mysql --console --bind-address=0.0.0.0 --init-file="$init_file"
