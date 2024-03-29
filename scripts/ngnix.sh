#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar Nginx
############################################

export LANG=C.UTF-8

echo "Instalando o Nginx..."

#apt-add-repository ppa:nginx/stable -r -y
apt-add-repository ppa:ondrej/php -y
apt-add-repository ppa:ondrej/apache2 -y

apt-get update -q
apt-get install -y nginx \
                   php7.4-fpm \
                   nginx-extras

service nginx reload
service nginx restart

systemctl enable nginx.service
