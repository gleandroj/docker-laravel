FROM ubuntu

ARG APP_ENV="local"
ENV DEPLOY_USER="deploy" \
    APP_DOMAIN="app.localhost" \
    APP_ENV=${APP_ENV}

COPY ./scripts/base.sh /tmp/

RUN useradd ${DEPLOY_USER} && \
    chmod +x -R /tmp/* && \
    /tmp/base.sh

COPY ./scripts/features/* /tmp/

RUN /tmp/node.sh && \
    /tmp/php.sh  && \
    /tmp/ngnix.sh && \
    /tmp/setup.sh

WORKDIR /home/deploy/app

ENTRYPOINT ["bash", "/scripts/init.sh"]
