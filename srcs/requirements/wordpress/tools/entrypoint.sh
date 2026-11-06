#!/bin/sh
set -eu

# Grab secrets
db_password=$(cat /run/secrets/db_user_password)
wp_admin_password=$(cat /run/secrets/wp_admin_password)

# Create WordPress directory
wordpress_dir=/var/www/html
mkdir -p "$wordpress_dir"

# Configure WordPress if wp-config.php does not exist
if [ ! -f "$wordpress_dir/wp-config.php" ]; then
    wp core download --path="$wordpress_dir" --allow-root
    wp config create \
        --path="$wordpress_dir" \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$db_password" \
        --dbhost="$DB_HOST" \
        --allow-root
fi

# Install WordPress if not already installed (Skip initial setup on site visit)
if ! wp core is-installed --path="$wordpress_dir" --allow-root; then
    wp core install \
        --path="$wordpress_dir" \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
		--admin_password="$wp_admin_password" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
fi

# Allow php-fpm to write to files
# Change ownership to www-data user and group
chown -R www-data:www-data "$wordpress_dir"

# Start php-fpm
exec /usr/sbin/php-fpm8.2 -F
