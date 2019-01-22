#!/bin/bash
set -e

## Monitora e inicia servicos
echo -e "\nIniciando os servicos..."
service php7.1-fpm start
service nginx stop

## Inicia o nginx
echo -e "\nRodando o Nginx..."
/usr/sbin/nginx -g "daemon off;"