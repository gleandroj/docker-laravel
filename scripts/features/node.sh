#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar Node.JS
############################################

echo "Instalando Node.JS..."
curl -sL https://deb.nodesource.com/setup_12.x -o /nodesource_setup.sh
chmod +x /nodesource_setup.sh

bash /nodesource_setup.sh
rm /nodesource_setup.sh

apt-get update
apt-get install -y nodejs

# Instala pacotes npm
npm install -g @angular/cli