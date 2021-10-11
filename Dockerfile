FROM php:7.4.22-fpm

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    build-essential \
    tzdata \
    git-core \
    curl \
    software-properties-common \
    gnupg2 \
    systemd \
    ssh \
    libzbar0 \
    libxml2 \
    libnss3-dev \
    wget \
    unzip \
    imagemagick \
    libzmq3-dev \
    libpcre3 \
    postgresql-client \
    libmagickwand-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libzip-dev \
    libedit-dev \
    libpq-dev \
    libc-client-dev \
    libkrb5-dev \
    libmcrypt-dev && \
    apt-get update && \
    apt-get install -y libgmp-dev && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    gpg-agent --daemon --use-standard-socket && \
    rm -r /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \ 
    composer self-update

RUN pecl install imagick mcrypt && \ 
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install imap && \
    docker-php-ext-enable imagick mcrypt && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install pgsql pdo_pgsql curl mbstring xml && \
    docker-php-ext-install json zip bcmath intl readline dba opcache gmp calendar && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY setup.sh /tmp

RUN ls -la /tmp && chmod +x /tmp/setup.sh && bash /tmp/setup.sh

EXPOSE 9000