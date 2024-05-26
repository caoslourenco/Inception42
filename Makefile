up:
	@sudo docker-compose -f ./srcs/docker-compose.yml up -d --build
down:
	@sudo docker-compose -f ./srcs/docker-compose.yml down
setup:
	@sudo mkdir -p /home/clourenc/data/wordpress/
	@sudo mkdir -p /home/clourenc/data/mariadb/
	@sudo chmod 777 /etc/hosts
	@sudo cat /etc/hosts | grep clourenc.42.fr || sudo echo "127.0.0.1 clourenc.42.fr" >> /etc/hosts
ps:
	@sudo docker ps
prune:
	@sudo docker system prune -a --force --volumes