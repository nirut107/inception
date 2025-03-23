#!/bin/bash

cd /var/www/html

if [ -z "$(ls -A /var/www/html)" ]; then
    cp -r /var/www/wordpress/. /var/www/html/
fi

until mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" &>/dev/null; do
    echo "MariaDB is not ready yet. Waiting..."
    sleep 2
done

if ! grep -q ${MYSQL_DATABASE} /var/www/html/wp-config.php; then
    echo "Creating wp-config.php..."
    wp core config --dbhost=mariadb \
                   --dbname=${MYSQL_DATABASE} \
                   --dbuser=${MYSQL_USER} \
                   --dbpass=${MYSQL_PASSWORD} \
                   --allow-root

    echo "Installing WordPress..."
    wp core install --title=${WP_TITLE} \
                    --admin_user=${WP_ADMIN_USER} \
                    --admin_password=${WP_ADMIN_PASSWORD} \
                    --admin_email=${WP_ADMIN_EMAIL} \
                    --url=https://${DOMAIN_NAME}/ \
                    --allow-root
    
    echo "Configuring Redis caching..."
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
    echo "define( 'WP_CACHE', true );" >> /var/www/html/wp-config.php
    echo "define( 'WP_REDIS_HOST', 'redis' );" >> /var/www/html/wp-config.php
    echo "define( 'WP_REDIS_PORT', 6379 );" >> /var/www/html/wp-config.php
fi

if ! wp user get ${WP_USER} --allow-root; then
    echo "Creating user ${WP_USER}..."
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
                   --role=author \
                   --user_pass=${WP_USER_PASSWORD} \
                   --allow-root
fi


php-fpm7.4 -F