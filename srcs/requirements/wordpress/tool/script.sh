#!/usr/bin/env bash
# Define o interpretador do script como Bash, localizado no ambiente do sistema.

wp --allow-root config create \
    --dbname="$DB_NAME" \
    --dbuser="$ADMIN_NAME" \
    --dbpass="$ADMIN_PASSWORD" \
    --dbhost=mariadb \
    --dbprefix="wp_"
# Cria o arquivo de configuração do Wordpress com as credenciais do banco de dados.
# --allow-root: Permite a execução do comando como root.
# --dbname: Nome do banco de dados.
# --dbuser: Nome do usuário do banco de dados.
# --dbpass: Senha do usuário do banco de dados.
# --dbhost: Host do banco de dados (neste caso, o container MariaDB).
# --dbprefix: Prefixo das tabelas do banco de dados.

wp core install --allow-root \
    --path=/var/www/wordpress \
    --title="$TITLE" \
    --url=$DOMAIN \
    --admin_user=$ADMIN_NAME \
    --admin_password=$ADMIN_PASSWORD \
    --admin_email=$ADMIN_EMAIL
# Instala o núcleo do Wordpress com as configurações iniciais.
# --path: Caminho onde o Wordpress está instalado.
# --title: Título do site Wordpress.
# --url: URL do site Wordpress.
# --admin_user: Nome do administrador.
# --admin_password: Senha do administrador.
# --admin_email: Email do administrador.

wp user create --allow-root \
    --path=/var/www/wordpress \
    "$USER_NAME" "$USER_EMAIL" \
    --user_pass=$USER_PASSWORD \
    --role='author'
# Cria um usuário adicional no Wordpress com a função de autor.
# --path: Caminho onde o Wordpress está instalado.
# --user_pass: Senha do usuário.
# --role: Função do usuário (neste caso, autor).

# Activate the Twenty Twenty-Two theme.
wp --allow-root theme activate twentytwentytwo
# Ativa o tema Twenty Twenty-Two no Wordpress.

exec php-fpm7.4 -F
# Inicia o servidor PHP-FPM em primeiro plano.
# -F: Mantém o PHP-FPM no primeiro plano (não daemoniza).
