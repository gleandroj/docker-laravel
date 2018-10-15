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
cd android-sdk-linux/tools

# install all sdk packages
./android update sdk --no-ui

# adb
#apt-get install libc6:i386 libstdc++6:i386
apt-get install android-tools-adb -y
# aapt
#apt-get install zlib1g:i386

mv /android-sdk-linux/** /usr/lib/android-sdk
rm -rf android-sdk_r24.2-linux.tgz

chmod 777 /opt/android-sdk/

export PATH=${PATH}:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/opt/android-sdk/build-tools/22.0.1/
export ANDROID_HOME=/opt/android-sdk/