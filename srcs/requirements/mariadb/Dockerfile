FROM debian:11

ARG WORDPRESS_DATABASE
ARG WORDPRESS_USER
ARG WORDPRESS_PASSWORD

RUN apt update && apt install -y mariadb-server

RUN echo "[mysqld] \n\
skip-networking=0 \n\
skip-bind-address \n" >> etc/mysql/my.cnf

COPY ./conf/dump.sql /tmp/dump.sql

RUN service mariadb start && \
	mariadb -u root -e \
	"CREATE DATABASE IF NOT EXISTS $WORDPRESS_DATABASE; \
	CREATE USER '$WORDPRESS_USER'@'%' identified by '$WORDPRESS_PASSWORD'; \
	GRANT ALL ON wordpress_db.* TO '$WORDPRESS_USER'@'%' IDENTIFIED BY '$WORDPRESS_PASSWORD'; \
	FLUSH PRIVILEGES;" && \
	mariadb -u root $WORDPRESS_DATABASE < /tmp/dump.sql && \
	service mariadb stop

CMD [ "mysqld_safe" ]