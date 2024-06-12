FROM debian:oldstable
# Usa a imagem base Debian na versão "oldstable".

WORKDIR /var/www/wordpress
# Define o diretório de trabalho dentro do container como "/var/www/wordpress".

RUN apt update && apt upgrade -y \
    && apt install php7.4 php-fpm php-mysql \
       mariadb-client wordpress wget -y \
    && rm -rf /var/lib/apt/lists/*
# Atualiza os pacotes existentes e instala PHP 7.4, PHP-FPM, PHP-MySQL, cliente MariaDB, 
# Wordpress e wget. Em seguida, remove a lista de pacotes para reduzir o tamanho da imagem.

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp \
    && wp core download --allow-root --path=/var/www/wordpress
# Baixa o WP-CLI, dá permissão de execução e o coloca no diretório "/usr/local/bin" para que 
# esteja disponível no PATH. Depois, usa o WP-CLI para baixar o núcleo do Wordpress.

RUN mkdir /run/php
# Cria o diretório necessário para executar o PHP-FPM.

RUN chown -R www-data:www-data /var/www/wordpress \
    && chmod 755 /var/www/wordpress
# Altera o proprietário dos arquivos do Wordpress para "www-data" (usuário padrão do servidor web)
# e define permissões de leitura e execução para o proprietário e grupo.

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# Copia o arquivo de configuração PHP-FPM para o local correto dentro do container.

COPY tool/script.sh /tmp/wp_setup.sh
# Copia o script de configuração do Wordpress para o diretório temporário dentro do container.

RUN chmod 777 /tmp/wp_setup.sh
# Dá permissões de execução para o script de configuração do Wordpress.

ENTRYPOINT ["/tmp/wp_setup.sh"]
# Define o script de configuração do Wordpress como o ponto de entrada do container.
# Isso significa que quando o container for iniciado, o script será executado.
