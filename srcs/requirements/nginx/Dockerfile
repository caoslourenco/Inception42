FROM debian:11

RUN apt update && apt upgrade -y && \
	apt install -y nginx && apt install openssl -y

RUN openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
	-keyout /etc/ssl/private/localhost.key \
	-out /etc/ssl/certs/localhost.crt

COPY ./conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]