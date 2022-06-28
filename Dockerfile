FROM gleandroj/laravel:master
ENV DEPLOY_USER="deploy"
COPY ./scripts/* /tmp/
RUN chmod +x -R /tmp/* && \
    /tmp/android.sh
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64" \
    GRADLE_HOME="/opt/gradle-4.1" \
    KOTLIN_HOME="/opt/kotlinc" \
    ANDROID_HOME="/opt/android-sdk" \
    _JAVA_OPTIONS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
ENV PATH="${PATH}:${ANDROID_HOME}/cmake/bin:${GRADLE_HOME}/bin:${KOTLIN_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${ANDROID_NDK_HOME}"
RUN apt-get install -y locales && \
    locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
