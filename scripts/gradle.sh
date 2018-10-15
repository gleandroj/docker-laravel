#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar Gradle
############################################

echo "Instalando Gradle..."

apt-get install -y unzip

wget https://services.gradle.org/distributions/gradle-4.1-all.zip

mkdir /opt/gradle
unzip -d /opt/gradle gradle-3.4.1-bin.zip
export PATH=$PATH:/opt/gradle/gradle-3.4.1/bin

rm -rf gradle-*.zip