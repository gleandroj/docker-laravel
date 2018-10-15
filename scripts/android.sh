#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar Android SDK
############################################

echo "Instalando Android SDK..."

# download android sdk
wget http://dl.google.com/android/android-sdk_r24.2-linux.tgz

tar -xvf android-sdk_r24.2-linux.tgz


mv /android-sdk-linux/** /opt/android-sdk/
rm -rf android-sdk_r24.2-linux.tgz

export PATH=${PATH}:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/opt/android-sdk/build-tools/22.0.1/
export ANDROID_HOME=/opt/android-sdk/

chmod -R 777 /opt/android-sdk/

# install all sdk packages
android update sdk --no-ui
