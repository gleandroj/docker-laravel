#!/bin/bash
set -e

############################################
## Configura o SUDO
############################################

source /etc/environment

echo "\nInstalando sudo..."

apt-get install sudo

echo "\nConfigurando o SUDO..."

adduser ${DEPLOY_USER} sudo
echo "${DEPLOY_USER} ALL=(ALL) NOPASSWD:SETENV:ALL" >> /etc/sudoers