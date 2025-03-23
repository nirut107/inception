#!/bin/bash

if [ ! -d "/home/store" ]; then
    echo "Error: /home/store does not exist."
    exit 1
fi

if [ ! -d "/var/www/html" ]; then
    mkdir -p /var/www/html
fi

if [ -z "$(ls -A /var/www/html)" ]; then
    cp -r /home/store/. /var/www/html/
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
fi

tail -f /dev/null