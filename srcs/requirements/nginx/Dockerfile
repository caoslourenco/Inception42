FROM debian:oldstable
# Usa a imagem base Debian na versão "oldstable".

RUN apt update -y && apt upgrade -y \
    && apt install nginx openssl -y
# Atualiza os pacotes existentes e instala o Nginx e o OpenSSL.

RUN openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
    -keyout /etc/ssl/private/private.key \
    -out /etc/ssl/certs/certificate.crt \
    -subj "/C=BR/ST=SP/L=Sao Paulo/O=42sp/CN=clourenc.42.fr"
# Gera um certificado SSL autoassinado com OpenSSL.
# -batch: Não pede confirmação interativa.
# -x509: Gera um certificado X.509.
# -sha256: Usa o algoritmo de hash SHA-256.
# -nodes: Não criptografa a chave privada.
# -newkey rsa:2048: Cria uma nova chave RSA de 2048 bits.
# -days 365: Validade do certificado de 365 dias.
# -keyout: Local para salvar a chave privada.
# -out: Local para salvar o certificado.
# -subj: Define os campos do certificado (país, estado, localidade, organização e nome comum).

COPY ./conf/nginx.conf /etc/nginx/conf.d
# Copia o arquivo de configuração personalizado do Nginx para o diretório de configuração do Nginx.

RUN chmod 755 /var/www
# Define permissões de leitura, escrita e execução para o proprietário e leitura e execução para grupo e outros no diretório "/var/www".

RUN chown -R www-data:www-data /var/www
# Altera o proprietário do diretório "/var/www" para "www-data" (usuário padrão do servidor web Nginx).

CMD ["nginx", "-g", "daemon off;"]
# Define o comando padrão a ser executado quando o container inicia.
# "-g 'daemon off;'": Mantém o Nginx no primeiro plano (não daemoniza), necessário para que o container continue em execução.
