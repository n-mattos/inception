# **Description**
The Inception project is about virtualization and containerization. The goal is to virtualize several Docker images, and create them inside a virtual machine.
The project demands the use of Docker and Docker Compose to create a container for nginx, WordPress, and MariaDB.
The containers communicate with each other through a Docker network.

# **Instructions**
### Starting the Virtual Machine and Containers
1. Launch the virtual machine through Oracle VirtualBox.
2. Connect to the virtual machine using SSH. (Can be done through VSCode)
3. Run `docker-compose up -d` to start the containers.
4. To stop the containers, run `docker-compose down`.

### Accessing the WordPress Site
1. To open the browser, use the command `startx`, then right-click and select `Web Browser` to open the browser.
2. Access the WordPress site by navigating to `---` in your web browser.

### Accessing the WordPress Admin Panel
1. To access the WordPress admin panel, navigate to `---/wp-admin` in your web browser.
2. Log in using the credentials provided during the WordPress installation process.

### Locate and Manage Credentials

### Check that Services are Running
1. To check that the services are running, you can use the command `docker ps` to see a list of running containers.
2. Use `sudo systemctl status <service_name>` to check the status of specific services like ssh, docker, etc.
