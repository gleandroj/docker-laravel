export SDK_HOME=/opt

apt-get --quiet update --yes
apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 git openjdk-17-jdk --no-install-recommends

# Gradle
export GRADLE_VERSION=8.0.2

export GRADLE_SDK_URL=https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip

curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  \
	&& unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME}  \
	&& rm -rf gradle-${GRADLE_VERSION}-bin.zip

export GRADLE_HOME=${SDK_HOME}/gradle-${GRADLE_VERSION}

export PATH=${GRADLE_HOME}/bin:$PATH

# android sdk|build-tools|image
export ANDROID_TARGET_SDK="android-28" \
    ANDROID_BUILD_TOOLS="34.0.0" \
    ANDROID_SDK_TOOLS="10406996" \
    ANDROID_IMAGES="sys-img-armeabi-v7a-android-28,sys-img-armeabi-v7a-android-28"   

# https://developer.android.com/studio#command-line-tools-only
export ANDROID_SDK_URL=https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip

mkdir -p ${SDK_HOME}/android-sdk/cmdline-tools

curl -sSL "${ANDROID_SDK_URL}" -o android-sdk-linux.zip \
    && unzip android-sdk-linux.zip -d ${SDK_HOME}/android-sdk/cmdline-tools \
  && rm -rf android-sdk-linux.zip

mv ${SDK_HOME}/android-sdk/cmdline-tools/cmdline-tools ${SDK_HOME}/android-sdk/cmdline-tools/tools 

# Set ANDROID_HOME

export ANDROID_HOME=${SDK_HOME}/android-sdk

export PATH=${ANDROID_HOME}/cmdline-tools/tools/bin:$PATH

# licenses
mkdir $ANDROID_HOME/licenses
echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license
echo d56f5187479451eabf01fb78af6dfcb131a6481e >> $ANDROID_HOME/licenses/android-sdk-license
echo 24333f8a63b6825ea9c5514f83c2829b004d1fee >> $ANDROID_HOME/licenses/android-sdk-license
echo 84831b9409646a918e30573bab4c9c91346d8abd > $ANDROID_HOME/licenses/android-sdk-preview-license

# Update and install using sdkmanager 
echo yes | sdkmanager "tools" "platform-tools"
echo yes | sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
echo yes | sdkmanager "platforms;${ANDROID_TARGET_SDK}"
echo yes | sdkmanager "extras;android;m2repository" "extras;google;google_play_services" "extras;google;m2repository"
echo yes | sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"
echo yes | sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"

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
rm -rf android-cmake.zip

npm i -g cordova @ionic/cli
