FROM debian:bullseye

EXPOSE 9000

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysqli \
    php7.4-xml \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-gd \
    mariadb-client \
    curl && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d

RUN mkdir -p /var/www/html && mkdir -p /var/www/wordpress && curl https://wordpress.org/latest.tar.gz --output /var/www/latest.tar.gz

RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

RUN tar -xvf /var/www/latest.tar.gz --strip-components=1 -C /var/www/wordpress && \
    rm -rf /var/www/latest.tar.gz

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent && \
    chmod +x /usr/bin/wp

RUN mkdir /run/php

COPY ./tools/script.sh ./script.sh
RUN chmod +x ./script.sh

ENTRYPOINT ["./script.sh"]
