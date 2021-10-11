#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Configura o PHP-FPM
############################################

source /etc/environment

echo "Configurando o PHP..."

# Altera configuracoes do PHP-CLI
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /usr/local/etc/php/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /usr/local/etc/php/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /usr/local/etc/php/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /usr/local/etc/php/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /usr/local/etc/php/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /usr/local/etc/php/php.ini
sed -i "s/short_open_tag = Off/short_open_tag = On/" /usr/local/etc/php/php.ini

# Altera as configuracoes do PHP-FPM
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /usr/local/etc/php/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /usr/local/etc/php/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /usr/local/etc/php/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /usr/local/etc/php/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /usr/local/etc/php/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /usr/local/etc/php/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /usr/local/etc/php/php.ini
sed -i "s/short_open_tag = Off/short_open_tag = On/" /usr/local/etc/php/php.ini


echo "Configurando o NGINX..."

export DOLLAR='$'
export APP_DOMAIN="_"
export APP_DIR="/var/www/html"

# Configura o Gzip
cat > /etc/nginx/conf.d/gzip.conf << EOF
gzip_comp_level 5;
gzip_min_length 256;
gzip_proxied any;
gzip_vary on;
gzip_types
application/atom+xml
application/javascript
application/json
application/rss+xml
application/vnd.ms-fontobject
application/x-font-ttf
application/x-web-app-manifest+json
application/xhtml+xml
application/xml
font/opentype
image/svg+xml
image/x-icon
text/css
text/plain
text/x-component;
EOF

#Remove o site padrao
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

#Configura o 404 no nginx quando nao encontrado
cat > /etc/nginx/sites-available/catch-all << EOF
server {
    return 404;
}
EOF
ln -s /etc/nginx/sites-available/catch-all /etc/nginx/sites-enabled/catch-all

#Gerando template para Nginx com Laravel
touch /etc/nginx/sites-available/site-laravel
cat > /etc/nginx/sites-available/site-laravel << EOF
server {
    listen 80 default_server;
    server_name ${APP_DOMAIN};
    # Pasta dos arquivos estaticos
    root ${APP_DIR}/public;
    
    # Configuracoes de seguranca
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";
    
    # Configura Controle de Origin para Cordova
    more_set_headers 'Access-Control-Allow-Origin: ${DOLLAR}http_origin';
    more_set_headers 'Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE, HEAD';
    more_set_headers 'Access-Control-Allow-Credentials: true';
    more_set_headers 'Access-Control-Allow-Headers: Origin,Content-Type,Accept,Authorization,x-xsrf-token';

    index index.html index.htm index.php;
    charset utf-8;

    # Tamanho maximo para upload
    client_max_body_size 100m;

    location / {
        try_files ${DOLLAR}uri ${DOLLAR}uri/ /index.php?${DOLLAR}query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    access_log off;
    error_log  /var/log/nginx/${APP_DOMAIN}-error.log error;
    error_page 404 /index.php;

    location ~ \.php${DOLLAR} {
        include snippets/fastcgi-php.conf;
        fastcgi_pass localhost:9000;
    }
    location ~ /\.ht {
        deny all;
    }
    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF


## Habilita Site Local
cp /etc/nginx/sites-available/site-laravel /etc/nginx/sites-enabled/site-laravel

# Testa o Nginx
nginx -t

echo "Limpando o sistema..."
apt-get -qq autoclean
apt-get -qq autoremove

mv /tmp/entry.sh /
rm /tmp/setup.sh
#