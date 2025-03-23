FROM debian:bullseye


RUN apt -y update && \
    apt install -y nginx openssl curl && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    mkdir -p /var/www/myapp && \
    chown -R www-data:www-data /var/www/myapp && \
    chmod -R 755 /var/www/myapp

RUN /usr/local/bin/script.sh

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]