FROM ubuntu

ENV DEPLOY_USER deploy
ENV APP_DOMAIN "app.localhost"
ARG APP_ENV="testing"
ENV APP_ENV=${APP_ENV}

COPY ./scripts/* /tmp/

RUN useradd ${DEPLOY_USER} && \
chmod +x -R /tmp/* && \
/tmp/base.sh && \
/tmp/node.sh && \
/tmp/php.sh  && \
/tmp/ngnix.sh && \
/tmp/setup.sh && \
mkdir -p /scripts

COPY ./scripts/init.sh /scripts

RUN chown $USER:$USER /scripts && \
    chmod +x /scripts/*.sh && \
    mkdir -p /home/deploy/app && \
    chown -R $USER:$USER /home/deploy

WORKDIR /home/deploy/app

ENTRYPOINT ["bash", "/scripts/init.sh"]