#!/bin/bash 
set -ex 

export DEBIAN_FRONTEND=noninteractive

############################################
## Instalar pacotes base
############################################

echo "Instalando pacotes base..."

apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    build-essential \
    tzdata \
    git-core \
    cron \
    curl \
    software-properties-common \
    ruby-full \
    gnupg2 \
    systemd \
    ssh \
    libzbar0 \
    libxml2 \
    libnss3-dev \
    wget \
    unzip

############################################
## Atualizar pacotes
############################################

echo "Atualizando pacotes..."

apt-get update
apt-get upgrade -y -o Dpkg::Options::="--force-confold"

gpg-agent --daemon --use-standard-socket