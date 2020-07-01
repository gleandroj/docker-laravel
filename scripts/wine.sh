#!/bin/bash 
set -ex 

export DEBIAN_FRONTEND=noninteractive

echo "Configurando Repositórios..."
############################################
## Configurar Repositórios
############################################

dpkg --add-architecture i386
wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
add-apt-repository ppa:cybermax-dexter/sdl2-backport

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

apt install --install-recommends winehq-stable -y
