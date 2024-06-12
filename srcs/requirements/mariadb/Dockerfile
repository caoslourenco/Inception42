FROM debian:oldstable
# Usa a imagem base Debian na versão "oldstable".

ARG ADMIN_NAME
ARG ADMIN_PASSWORD
ARG DB_NAME
# Define argumentos de build que podem ser passados durante a construção da imagem.
# Esses argumentos podem ser usados para configurar o container.

RUN apt update -y && apt upgrade -y \
    && apt install mariadb-server -y \
    && rm -rf /var/lib/apt/lists/*
# Atualiza os pacotes existentes e instala o servidor MariaDB.
# Depois, remove a lista de pacotes para reduzir o tamanho da imagem.

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld
# Cria o diretório necessário para o MariaDB e ajusta as permissões.
# O MariaDB precisa desse diretório para armazenar seus arquivos de execução.

COPY conf/my.cnf /etc/mysql/my.cnf
# Copia o arquivo de configuração do MariaDB para o diretório correto no container.

COPY tool/script.sh /tmp/script.sh
# Copia um script personalizado para o diretório temporário do container.

RUN chmod 777 /tmp/script.sh && bash /tmp/script.sh
# Concede permissões de execução ao script e o executa.

CMD ["mysqld_safe"]
# Define o comando padrão a ser executado quando o container inicia.
# 'mysqld_safe' é um wrapper usado para iniciar o servidor MariaDB.
