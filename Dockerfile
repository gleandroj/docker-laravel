FROM ubuntu

ARG APP_ENV="testing"
ENV DEPLOY_USER="deploy" \
    APP_DOMAIN "app.localhost" \    
    APP_ENV=${APP_ENV}

COPY ./scripts/* /tmp
RUN useradd ${DEPLOY_USER} && \
    chmod +x -R /tmp/* && \
    /tmp/base.sh && \
    /tmp/sudo.sh && \
    /tmp/java.sh && \
    /tmp/imagemagick.sh && \
    /tmp/node.sh && \
    /tmp/ngnix.sh && \
    /tmp/certbot.sh && \
    /tmp/php.sh && \
    /tmp/heroku.sh && \
    /tmp/gems.sh && \
    /tmp/google-chrome.sh && \
    /tmp/android.sh && \
    /tmp/setup.sh

COPY ./scripts/init.sh /scripts
RUN chown $USER:$USER /scripts && \
    chmod +x /scripts/*.sh && \
    mkdir -p /home/deploy/app && \
    chown -R $USER:$USER /home/deploy

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV GRADLE_HOME /opt/gradle-4.1
ENV KOTLIN_HOME /opt/kotlinc
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/cmake/bin:${GRADLE_HOME}/bin:${KOTLIN_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${ANDROID_NDK_HOME}
ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

WORKDIR /home/deploy/app

ENTRYPOINT ["bash", "/scripts/init.sh"]