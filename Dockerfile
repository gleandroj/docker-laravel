FROM ubuntu

ENV DEPLOY_USER deploy
ENV APP_DOMAIN "app.localhost"
ARG APP_ENV="testing"
ENV APP_ENV=${APP_ENV}

COPY ./scripts/base.sh /tmp/base.sh
RUN chmod +x /tmp/base.sh && \
/tmp/base.sh

COPY ./scripts/base.sh /tmp/sudo.sh
RUN chmod +x /tmp/sudo.sh && \
/tmp/sudo.sh

COPY ./scripts/java.sh /tmp/java.sh
RUN chmod +x /tmp/java.sh && \
/tmp/java.sh

COPY ./scripts/imagemagick.sh /tmp/imagemagick.sh
RUN chmod +x /tmp/imagemagick.sh && \
/tmp/imagemagick.sh

COPY ./scripts/node.sh /tmp/node.sh
RUN chmod +x /tmp/node.sh && \
/tmp/node.sh

COPY ./scripts/ngnix.sh /tmp/ngnix.sh
RUN chmod +x /tmp/ngnix.sh && \
/tmp/ngnix.sh

COPY ./scripts/certbot.sh /tmp/certbot.sh
RUN chmod +x /tmp/certbot.sh && \
/tmp/certbot.sh

COPY ./scripts/php.sh /tmp/php.sh
RUN chmod +x /tmp/php.sh && \
/tmp/php.sh

COPY ./scripts/heroku.sh /tmp/heroku.sh
RUN chmod +x /tmp/heroku.sh && \
/tmp/heroku.sh

COPY ./scripts/gems.sh /tmp/gems.sh
RUN chmod +x /tmp/gems.sh && \
/tmp/gems.sh

COPY ./scripts/google-chrome.sh /tmp/google-chrome.sh
RUN chmod +x /tmp/google-chrome.sh && \
/tmp/google-chrome.sh

COPY ./scripts/android.sh /tmp/android.sh
RUN chmod +x /tmp/android.sh && \
/tmp/android.sh

COPY ./scripts/gradle.sh /tmp/gradle.sh
RUN chmod +x /tmp/gradle.sh && \
/tmp/gradle.sh

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

#env JAVA_HOME="/usr/bin/java"
env PATH=$PATH:/opt/gradle/gradle-4.1/bin
env PATH=${PATH}:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/opt/android-sdk/build-tools/22.0.1/
env ANDROID_HOME=/opt/android-sdk/

## onbuild
ONBUILD USER root

ONBUILD COPY . /home/deploy/app

ONBUILD COPY ./scripts/onbuild.sh /tmp/onbuild.sh

ONBUILD RUN chmod +x /tmp/onbuild.sh && \
/tmp/onbuild.sh

ONBUILD USER deploy

WORKDIR /home/deploy/app

ENTRYPOINT ["bash", "/scripts/init.sh"]