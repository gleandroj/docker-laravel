#!/bin/bash 
set -ex

export DEBIAN_FRONTEND=noninteractive 

############################################
## Instalar Android SDK
############################################

echo "Instalando Android SDK..."

#apt-get install -y android-sdk
export GRADLE_VERSION=4.10
export ANDROID_SDK_VERSION=4333796

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export GRADLE_HOME=/opt/gradle
export KOTLIN_HOME=/opt/kotlinc
export ANDROID_HOME=/opt/android-sdk
export PATH=${PATH}:${GRADLE_HOME}/bin:${KOTLIN_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
export _JAVA_OPTIONS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
export SDK_HOME=/opt/
export ANDROID_NDK_VERSION=r16b
export ANDROID_NDK_URL=http://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
export ANDROID_NDK_HOME=${SDK_HOME}/android-ndk-${ANDROID_NDK_VERSION}
export PATH=${ANDROID_NDK_HOME}:${ANDROID_HOME}/cmake/bin:$PATH

cd /opt
wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip gradle*.zip
mv gradle-${GRADLE_VERSION} gradle
rm gradle*.zip

mkdir -p /opt/android-sdk
cd /opt/android-sdk
wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip
unzip *tools*linux*.zip
rm *tools*linux*.zip

curl -L "${ANDROID_NDK_URL}" -o android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip  \
  && unzip android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip -d ${SDK_HOME}  \
  && rm -rf android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip

wget -q https://dl.google.com/android/repository/cmake-3.6.3155560-linux-x86_64.zip -O android-cmake.zip
unzip -q android-cmake.zip -d ${ANDROID_HOME}/cmake

curl https://raw.githubusercontent.com/Cangol/android-gradle-docker/master/android-wait-for-emulator -o ${SDK_HOME}/bin/android-wait-for-emulator

chmod u+x ${JAVA_HOME}/ -R
chmod u+x ${KOTLIN_HOME}/ -R
chmod u+x ${GRADLE_HOME}/ -R
chmod u+x ${ANDROID_HOME}/ -R
chmod u+x ${ANDROID_NDK_HOME}/ -R
chmod u+x ${ANDROID_HOME}/cmake/bin/ -R
chmod u+x ${SDK_HOME}/bin/android-wait-for-emulator