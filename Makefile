COM_COLOR   = \033[0;34m
OBJ_COLOR   = \033[0;36m
NO_COLOR    = \033[m

COM_STRING   = "Compiling"

.PHONY: all re build run clean fclean status help confirm wipe

all: build run status ## Builds, launches, and displays the status of the containers.

re: fclean build run status	## Rebuilds the containers and launches them.

build: ## Builds the containers.
	@printf "%b" "$(COM_COLOR)$(COM_STRING) $(OBJ_COLOR)$(@)$(NO_COLOR)\n";
	@docker compose -f srcs/docker-compose.yml build

run: ## Launches the containers.
	@docker compose -f srcs/docker-compose.yml up -d

clean: ## Stops the containers.
	@docker compose -f srcs/docker-compose.yml down

fclean: clean ## Stops and removes the containers, networks, and volumes.
	@docker compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans

wipe: fclean ## Removes the volumes and their data.
	@read -p "Are you sure you want to remove the volumes and their data? [y/N] " answer; \
		if [ "$$answer" != "y" ] && [ "$$answer" != "Y" ]; then \
			echo "Operation cancelled."; \
			exit 1; \
		fi
	@sudo find /home/nmattos-/data/mariadb -mindepth 1 -delete
	@sudo find /home/nmattos-/data/wordpress -mindepth 1 -delete

status: ## Displays the status of the containers.
	@docker compose -f srcs/docker-compose.yml ps

log: ## Displays the logs of the containers.
	@docker compose -f srcs/docker-compose.yml logs

help: ## Displays the available commands and their descriptions.
	@awk 															\
		'BEGIN {													\
			FS = ":.*##";											\
			printf "Usage:\n make $(OBJ_COLOR)<target>$(NO_COLOR)\n"\
		}															\
		/^[a-zA-Z_0-9-]+:.*?##/ {									\
			printf " $(OBJ_COLOR)%-15s$(NO_COLOR) %s\n", $$1, $$2	\
		}															\
		/^##@/ {													\
			printf "\n\033[1m%s$(NO_COLOR)\n", substr($$0, 5)		\
		}															\
		' $(MAKEFILE_LIST)
