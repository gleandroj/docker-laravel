#!/bin/bash
set -e

echo "Teste de Inicialização"

## Monitora e inicia servicos
echo -e "\nIniciando os servicos..."

#service cron start
#service php7.1-fpm start
# service memcached restart

#monit stop nginx
#service nginx stop

#echo -e "\nIniciando o monit..."
#service monit start

# ## Crond
# monit start crond
# monit monitor crond

# ## PHP 7 FPM
# monit start php7-fpm
## Inicia o nginx
echo -e "\nRodando o Nginx..."
/usr/sbin/nginx -g "daemon off;"