FROM ubuntu

ENV DEPLOY_USER deploy
ENV APP_DOMAIN "app.localhost"
ARG APP_ENV="testing"
ENV APP_ENV=${APP_ENV}

COPY ./scripts/base.sh /tmp/base.sh
RUN chmod +x /tmp/base.sh && \
/tmp/base.sh

COPY ./scripts/java.sh /tmp/java.sh
RUN chmod +x /tmp/java.sh && \
/tmp/java.sh

COPY ./scripts/imagemagick.sh /tmp/imagemagick.sh
RUN chmod +x /tmp/imagemagick.sh && \
/tmp/imagemagick.sh

COPY ./scripts/node.sh /tmp/node.sh
RUN chmod +x /tmp/node.sh && \
/tmp/node.sh

COPY ./scripts/php.sh /tmp/php.sh
RUN chmod +x /tmp/php.sh && \
/tmp/php.sh

COPY ./scripts/android.sh /tmp/android.sh
RUN chmod +x /tmp/android.sh && \
/tmp/android.sh

RUN useradd ${DEPLOY_USER}

COPY ./scripts/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh && \
/tmp/setup.sh

RUN mkdir -p /scripts

COPY ./scripts/init.sh /scripts
RUN chown $USER:$USER /scripts && \
    chmod +x /scripts/*.sh && \
    mkdir -p /home/deploy/app && \
    chown -R deploy:deploy /home/deploy

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV GRADLE_HOME /opt/gradle-4.1
ENV KOTLIN_HOME /opt/kotlinc
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/cmake/bin:${GRADLE_HOME}/bin:${KOTLIN_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:${ANDROID_NDK_HOME}
ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

## onbuild
ONBUILD USER root

ONBUILD COPY . /home/deploy/app

ONBUILD COPY ./scripts/onbuild.sh /tmp/onbuild.sh

ONBUILD RUN chmod +x /tmp/onbuild.sh && \
/tmp/onbuild.sh

ONBUILD USER deploy

WORKDIR /home/deploy/app

ENTRYPOINT ["bash", "/scripts/init.sh"]