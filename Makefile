# Define o login do usuário e os diretórios para o MariaDB e WordPress.
LOGIN=clourenc
MARIA_DIR=/home/$(LOGIN)/data/mariadb
WORDPRESS_DIR=/home/$(LOGIN)/data/wordpress

# Define o arquivo docker-compose e o comando para usá-lo.
DOCKER_COMPOSE_FILE=./srcs/docker-compose.yaml
DOCKER_COMPOSE_COMMAND=docker-compose -f $(DOCKER_COMPOSE_FILE)

# Define as metas padrão que serão executadas quando o comando 'make' for chamado.
all: config up

# A meta 'config' inclui comandos de configuração inicial.
config:
	# Imprime "oi" no terminal.
	@echo oi

	# Se o arquivo .env não existir, baixa-o de um URL específico.
	@if [ ! -f ./srcs/.env ]; then \
		wget -O ./srcs/.env https://raw.githubusercontent.com/caoslourenco/Inception42/main/srcs/.env; \
	fi

	# Adiciona uma entrada ao /etc/hosts se o login não estiver presente.
	@if ! grep -q '$(LOGIN)' /etc/hosts; then \
		echo "127.0.0.1 $(LOGIN).42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi

	# Cria o diretório do WordPress se ele não existir.
	@if [ ! -d "$(WORDPRESS_DIR)" ]; then \
		sudo mkdir -p $(WORDPRESS_DIR); \
	fi
	
	# Cria o diretório do MariaDB se ele não existir.
	@if [ ! -d "$(MARIA_DIR)" ]; then \
		sudo mkdir -p $(MARIA_DIR); \
	fi

# A meta 'up' primeiro chama 'build' e depois sobe os serviços em modo destacável.
up: build
	$(DOCKER_COMPOSE_COMMAND) up -d

# A meta 'build' constrói os serviços definidos no arquivo docker-compose.
build:
	$(DOCKER_COMPOSE_COMMAND) build

# A meta 'down' derruba todos os serviços definidos no arquivo docker-compose.
down:
	$(DOCKER_COMPOSE_COMMAND) down

# A meta 'ps' lista o estado dos serviços definidos no arquivo docker-compose.
ps:
	$(DOCKER_COMPOSE_COMMAND) ps

# A meta 'ls' lista todos os volumes do Docker.
ls:
	docker volume ls

# A meta 'clean' derruba os serviços e remove todas as imagens e volumes.
clean:
	$(DOCKER_COMPOSE_COMMAND) down --rmi all --volumes

# A meta 'fclean' executa 'clean', remove todos os recursos do Docker e apaga os diretórios do projeto.
fclean: clean
	docker system prune --force --all --volumes
	sudo rm -rf /home/$(LOGIN)

# A meta 're' executa 'fclean' e depois 'all', reinicializando o projeto completamente.
re: fclean all

# Define as metas que não correspondem a arquivos reais.
.PHONY: all up config build down ls clean fclean hard update

# A meta 'hard' primeiro atualiza o sistema e depois executa todas as metas.
hard: update all

# A meta 'update' atualiza e atualiza os pacotes do sistema.
update:
	sudo apt-get update && sudo apt-get upgrade -yq

