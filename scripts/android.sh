#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar Android SDK
############################################

echo "Instalando Android SDK..."

#apt-get install -y android-sdk

export GRADLE_VERSION=4.10
cd /opt
wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip gradle*.zip
mv gradle-${GRADLE_VERSION} gradle
rm gradle*.zip

# download and install Kotlin compiler
# https://github.com/JetBrains/kotlin/releases/latest
export KOTLIN_VERSION=1.2.61
wget -q https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip
unzip *kotlin*.zip
rm *kotlin*.zip

export ANDROID_SDK_VERSION=4333796
mkdir -p /opt/android-sdk
cd /opt/android-sdk
wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip
unzip *tools*linux*.zip
rm *tools*linux*.zip

android update sdk --no-ui
