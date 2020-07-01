FROM gleandroj/laravel:slim

ENV DEPLOY_USER="deploy"

COPY ./scripts/* /tmp/
RUN chmod +x -R /tmp/* && \
    /tmp/wine.sh