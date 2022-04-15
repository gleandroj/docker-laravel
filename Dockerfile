FROM ubuntu

ARG APP_ENV="local"
ENV DEPLOY_USER="deploy" \
    APP_DOMAIN="app.localhost" \
    APP_ENV=${APP_ENV}

COPY ./scripts/* /tmp/

RUN useradd ${DEPLOY_USER} && \
    chmod +x -R /tmp/* && \
    /tmp/base.sh

RUN /tmp/node.sh && \
    /tmp/php.sh  && \
    /tmp/ngnix.sh && \
    /tmp/setup.sh
    
RUN composer self-update

WORKDIR /home/deploy/app

ENTRYPOINT ["bash", "/scripts/init.sh"]
