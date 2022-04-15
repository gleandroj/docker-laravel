#!/bin/bash
set -e

## Inicia servicos
echo -e "\nIniciando os servicos..."
service php7.4-fpm start

## Inicia o nginx
echo -e "\nRodando o Nginx..."
/usr/sbin/nginx -g "daemon off;"
