#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar Android SDK
############################################

echo "Instalando Android SDK..."

apt-get install -y android-sdk

export PATH=${PATH}:/usr/lib/android-sdk/platform-tools:/usr/lib/android-sdk/tools:/usr/lib/android-sdk/build-tools/24.0.0/
export ANDROID_HOME=/usr/lib/android-sdk

android update sdk --no-ui
