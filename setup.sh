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

echo "Limpando o sistema..."

apt-get -qq autoclean
apt-get -qq autoremove

rm -rf /tmp/* /var/tmp/*