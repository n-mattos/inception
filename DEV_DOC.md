# **Setup from Scratch**
...

# **Modify Ports**
- **Nginx (HTTPS):** `NGINX_PORT` in `srcs/.env` sets the host port, mapped to container port 443 in `srcs/docker-compose.yml`. For example, it can be changed to `8443` to access the site at `https://<login>.42.fr:8443`. Nginx still listens on 443. If WordPress is already installed, update its Site Address in **Settings > General**.

- **MariaDB:** listens on internal port 3306 and is not published to the host. To change its internal port, set `port = <port>` in `srcs/requirements/mariadb/conf/50-server.conf`, and set `DB_HOST=mariadb:<port>` in `srcs/.env`. For an installed site, also update `DB_HOST` in `wordpress_data`'s `wp-config.php`. This can be done using `docker compose exec wordpress wp config set DB_HOST 'mariadb:<port>' --path=/var/www/html --allow-root`\
Confirm using:\
`docker compose exec mariadb mariadb -uroot -p -Nse "SELECT @@port;"`\
`docker compose exec wordpress wp config get DB_HOST --path=/var/www/html --allow-root`\
`docker compose exec wordpress wp db check --path=/var/www/html --allow-root`

- **WordPress PHP-FPM:** listens on internal port 9000. To change it, update `listen = <port>` in `srcs/requirements/wordpress/conf/www.conf` and `fastcgi_pass wordpress:<port>` in `srcs/requirements/nginx/conf/nginx.conf` to match.\
Confirm using:\
`docker compose exec wordpress grep '^listen =' /etc/php/8.2/fpm/pool.d/www.conf`\
`PORT=9000; docker compose exec -e PORT="$PORT" wordpress php -r '$p=(int)getenv("PORT"); $s=@fsockopen("127.0.0.1",$p); echo $s ? "Port $p is open\n" : "Port $p is closed\n"; if ($s) fclose($s);'`

After changing any internal service port, rebuild and restart using `make re`.

# **Build and Manage**
A Makefile is provided to simplify the build/launch process of the containers. The available commands and their descriptions are listed below:

| Command | Description |
|---------|-------------|
| help | Displays the available commands and their descriptions.
| make | Builds, launches, and displays the status of the containers.
| re | Rebuilds the containers and launches them.
| build | Builds the containers.
| run | Launches the containers.
| clean | Stops the containers.
| fclean | Stops and removes the containers, networks, and volumes.
| wipe | Removes the volumes and their data.
| status | Displays the status of the containers.
| log | Displays the logs of the containers.

The most common procedure is:
1. `make` - Build and launch containers
2. `make clean` - Stop containers
3. `make re` - Rebuild and launch containers
4. `make log` - Display container logs for debugging

**Other Docker Commands**
- `docker compose logs -f` - Displays the logs of the containers in real-time.
- `docker compose volume ls` - Lists the volumes created by docker-compose.
- `docker compose config --images` - Displays the image names.
- `docker network ls` - Display network(s)

# **Data Storage**
The data is stored in named volumes, which are automatically created by docker-compose. These volumes are defined in `docker-compose.yml` and allow for persistent data storage across container restarts. These volumes are mounted to specific paths on the host machine. To find the location of these volumes you can inspect the `volume` section of `docker-compose.yml`.

# **Access mariadb**
Use `docker compose exec mariadb mariadb -u epicwordpressuser -p epicwordpressdb` to access mariadb. It will prompt you for a password which is found at `./secrets/db_password`.
Exit using `exit;`.

**SQL Commands**
- `SHOW TABLES;`
- `SELECT * FROM wp_users;`
- `SELECT comment_ID FROM wp_comments WHERE user_id = (SELECT ID FROM wp_users WHERE user_login = 'Lutz');`
