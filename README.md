*This project has been created as part of the 42 curriculum by nmattos-*

# **Description**
The Inception project is about virtualization and containerization. The goal is to virtualize several Docker images, and create them inside a virtual machine.
The project demands the use of Docker and Docker Compose to create a container for nginx, WordPress, and MariaDB.
The containers communicate with each other through a Docker network.

# **Instructions**
1. Launch the virtual machine through Oracle VirtualBox.
2. Connect to the virtual machine using SSH. (Can be done through VSCode)
3. Run `docker-compose up -d` to start the containers.
4. To open the browser, use the command `startx`, then right-click and select `Web Browser` to open the browser.
5. Access the WordPress site by navigating to `---` in your web browser.
6. To stop the containers, run `docker-compose down`.

# **Project Description**
The project consist of three main services: Nginx, WordPress, and MariaDB. The Nginx service acts as a reverse proxy for the WordPress service, which is a content management system (CMS) that allows users to create and manage websites. The MariaDB service is a database management system that stores the data for the WordPress site.

### Virtual Machine vs Docker
|	| Virtual Machine | Docker |
|-----|------------------|--------|
| Isolation | Runs its own OS, which provides strong isolation but requires more resources. | Share the host OS kernel, which provides lightweight isolation and faster startup times. |
| Performance | Higher overhead due to the additional OS layer. | More efficient as they share the host OS kernel. |
| Resource Usage | Consumes more CPU, memory, and storage resources. | Use fewer resources compared to virtual machines. |

### Secrets vs Environment Variables
|	| Secrets | Environment Variables |
|-----|------------------|--------|
| Security | Encrypted and stored securely, making them more secure for sensitive information. | Stored in plain text and can be accessed by anyone with access to the container, making them less secure. |
| Usage | Used for storing sensitive data like API keys, passwords, and tokens. | Used for storing non-sensitive configuration values like database URLs, port numbers, and other settings. |
| Storage | Mounted as files, which Docker can read from, but they are not accessible to the container's environment. | Stored in the container's environment (.env) and can be accessed by any process running in the container. |

### Docker Network vs Host Network
|	| Docker Network | Host Network |
|-----|------------------|--------|
| Isolation | Provides isolation between containers, allowing them to communicate with each other while being isolated from the host network. | Allows containers to share the host's network stack, which can lead to potential security risks and conflicts with other services running on the host. |
| Performance | Can sacrifice performance due to the additional network layer, but in turn provides better isolation and security. | Can provide better performance since it eliminates the additional network layer, but it sacrifices isolation and security. |
| Use Cases | Suitable for most use cases, especially when running multiple containers that need to communicate with each other. | Suitable for specific use cases where performance is critical, and the containers need to have direct access to the host's network stack. |

### Docker Volumes vs Bind Mounts
|	| Docker Volumes | Bind Mounts |
|-----|------------------|--------|
| Isolation | Managed by Docker and stored in a specific location on the host, providing better isolation and security. | Directly mounted from the host's filesystem, which can lead to potential security risks and conflicts with other services running on the host. |
| Performance | Can provide better performance since they are optimized for Docker and can be stored on faster storage devices. | Can sacrifice performance due to the additional overhead of accessing the host's filesystem, but in turn provides more flexibility and control over the data. |
| Use Cases | Suitable for most use cases, especially when running multiple containers that need to persist data across container restarts. | Suitable for specific use cases where the data needs to be shared between the host and the container, or when the data needs to be accessed by other services running on the host. |

# **Resources**
- [VM Installation](https://github.com/Bakr-1/inceptionVm-guide/blob/main/README.md)
- [Docker](https://github.com/vbachele/Inception/blob/main/README.md)