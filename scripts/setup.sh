#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

echo "Limpando o sistema..."

apt-get -qq autoclean
apt-get -qq autoremove

rm -rf /tmp/* /var/tmp/*