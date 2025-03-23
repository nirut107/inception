#!/bin/bash

# Generate a self-signed certificate if it doesn't exist
if [ ! -f /etc/ssl/private/nginx-selfsigned.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/private/nginx-selfsigned.crt \
        -subj "/C=TH/L=Bangkok/O=42Bangkok/OU=student/CN=nsomrod.42.fr"
fi

# Generate Nginx configuration file
cat > /etc/nginx/conf.d/default.conf <<EOF
server {
    listen          443 ssl;
    listen          [::]:443 ssl;
    server_name     nsomrod.42.fr;

    ssl_certificate /etc/ssl/private/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    ssl_protocols TLSv1.2 TLSv1.3;

    index index.php ;
    root /var/www/html;

    error_log /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        try_files \$uri =404; 
        include fastcgi_params;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param   SCRIPT_NAME     \$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }

    location /myapp {
        root /var/www/;
        index home.html;
    }
}

EOF
