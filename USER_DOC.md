# **Description**
The Inception project is about virtualization and containerization. The goal is to virtualize several Docker images, and create them inside a virtual machine.
The project demands the use of Docker and Docker Compose to create a container for nginx, WordPress, and MariaDB.
The containers communicate with each other through a Docker network.

# **Provided Services**
This project provides the following services:
- **Nginx**: A web server that serves as a reverse proxy for the WordPress container.
- **WordPress**: A content management system (CMS) that allows users to create and manage websites.
- **MariaDB**: A relational database management system that stores data for the WordPress website.
It does so by using Docker Compose to manage the services and their dependencies.
Each service is its own container, and they communicate with each other through a Docker network.

# **Instructions**
### Starting the Virtual Machine and Containers
1. Launch the virtual machine through Oracle VirtualBox.
2. Connect to the virtual machine using SSH. (Can be done through VSCode)
3. Run `make` to start the containers.
4. To stop the containers, run `make clean`.

### Accessing the WordPress Site
1. To open the browser, use the command `startx`, then right-click and select `Web Browser` to open the browser.
2. Access the WordPress site by navigating to `nmattos.42.fr` in your web browser.

### Accessing the WordPress Admin Panel
1. To access the WordPress admin panel, navigate to `nmattos.42.fr/wp-admin` in your web browser.
2. Log in using $(WP_ADMIN_USER) and ./secrets/wp_admin_password.

### Locate and Manage Credentials
1. Passwords are stored in the `secrets` directory. You can view them using `cat ./secrets/<password_file>`.
2. Other variables that are not sensitive are stored in the `.env` file. You can view them using `cat .env`.

### Check that Services are Running
1. To check that the services are running, you can use the command `docker ps` to see a list of running containers.
2. Use `sudo systemctl status <service_name>` to check the status of specific services like ssh, docker, etc.
