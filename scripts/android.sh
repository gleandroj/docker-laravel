export SDK_HOME=/opt

apt-get --quiet update --yes
apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 git --no-install-recommends
# Gradle
export GRADLE_VERSION=4.1
export GRADLE_SDK_URL=https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  \
	&& unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME}  \
	&& rm -rf gradle-${GRADLE_VERSION}-bin.zip
export GRADLE_HOME=${SDK_HOME}/gradle-${GRADLE_VERSION}
export PATH=${GRADLE_HOME}/bin:$PATH

# android sdk|build-tools|image
export ANDROID_TARGET_SDK="android-28" \
    ANDROID_BUILD_TOOLS="27.0.3" \
    ANDROID_SDK_TOOLS="3859397" \
    ANDROID_IMAGES="sys-img-armeabi-v7a-android-28,sys-img-armeabi-v7a-android-28"   
export ANDROID_SDK_URL=https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
curl -sSL "${ANDROID_SDK_URL}" -o android-sdk-linux.zip \
    && unzip android-sdk-linux.zip -d android-sdk-linux \
  && rm -rf android-sdk-linux.zip
  
# Set ANDROID_HOME
export ANDROID_HOME=$PWD/android-sdk-linux
export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH

# licenses
mkdir $ANDROID_HOME/licenses
echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license
echo d56f5187479451eabf01fb78af6dfcb131a6481e >> $ANDROID_HOME/licenses/android-sdk-license
echo 84831b9409646a918e30573bab4c9c91346d8abd > $ANDROID_HOME/licenses/android-sdk-preview-license

# Update and install using sdkmanager 
echo yes | $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools"
echo yes | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
echo yes | $ANDROID_HOME/tools/bin/sdkmanager "platforms;${ANDROID_TARGET_SDK}"
echo yes | $ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;google_play_services" "extras;google;m2repository"
echo yes | $ANDROID_HOME/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"
echo yes | $ANDROID_HOME/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"

# android ndk
export ANDROID_NDK_VERSION=r16b
export ANDROID_NDK_URL=http://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
curl -L "${ANDROID_NDK_URL}" -o android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip  \
  && unzip android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip -d ${SDK_HOME}  \
  && rm -rf android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
export ANDROID_NDK_HOME=${SDK_HOME}/android-ndk-${ANDROID_NDK_VERSION}
export PATH=${ANDROID_NDK_HOME}:$PATH
chmod u+x ${ANDROID_NDK_HOME}/ -R

# Android CMake
wget -q https://dl.google.com/android/repository/cmake-3.6.3155560-linux-x86_64.zip -O android-cmake.zip
unzip -q android-cmake.zip -d ${ANDROID_HOME}/cmake
export PATH=${PATH}:${ANDROID_HOME}/cmake/bin
chmod u+x ${ANDROID_HOME}/cmake/bin/ -R

#android-wait-for-emulator
#curl https://raw.githubusercontent.com/Cangol/android-gradle-docker/master/android-wait-for-emulator -o ${SDK_HOME}/bin/android-wait-for-emulator
#chmod u+x ${SDK_HOME}/bin/android-wait-for-emulator