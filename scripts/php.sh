#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar PHP 7.4
############################################

add-apt-repository ppa:ondrej/php

export LANG=C.UTF-8

echo "Instalando o PHP 7.4 ..."
#php7.4-memcached \

apt-get install -y  \
  libpcre3 \
  php7.4-cli \
  php7.4-dev \
  php7.4-pgsql \
  php7.4-sqlite3 \
  php7.4-gd \
  php7.4-curl \
  php7.4-imap \
  php7.4-mysql \
  php7.4-imagick \
  php7.4-mbstring \
  php7.4-xml \
  php7.4-json \
  php7.4-zip \
  php7.4-bcmath \
  php7.4-soap \
  php7.4-intl \
  php7.4-readline \
  php7.4-mcrypt \
  php7.4-dba \
  php7.4-opcache \
  php7.4-xdebug \
  postgresql-client

# Instala o Composer
echo "Instalando o Composer..."
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
