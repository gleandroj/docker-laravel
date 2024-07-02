#!/bin/bash 
set -ex 

export DEBIAN_FRONTEND=noninteractive

echo "Configurando Repositórios..."
############################################
## Configurar Repositórios
############################################

dpkg --add-architecture i386

echo "Atualizando pacotes..."
############################################
## Atualizar pacotes
############################################

apt update 
apt-get upgrade -y -o Dpkg::Options::="--force-confold"

echo "Instalando wine..."
############################################
## Instalar wine
############################################
apt install --install-recommends wine64 -y

ln -s /usr/bin/wine /usr/local/bin/wine64
