#!/bin/bash 
set -ex 
export DEBIAN_FRONTEND=noninteractive

########################
## Instala Google Chrome
########################

apt-get install -y \
        libxss1 \
        fonts-liberation \
        libappindicator3-1 \
        xdg-utils \
        libappindicator1 \
        libindicator7 \
        libgconf2-dev

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome*.deb
apt-get install -f -y
