FROM composer/composer:2.2 AS composer
FROM alpine:3.20.2

LABEL org.opencontainers.image.source="https://github.com/awesoft/magento-docker"
LABEL org.opencontainers.image.description="Magento 2 docker image"
LABEL org.opencontainers.image.authors="https://github.com/awesoft"
LABEL org.opencontainers.image.licenses="MIT"

ENV PS1='\u@\h:\w\$ '
ENV HISTFILE=/dev/null
ENV COMPOSER_MEMORY_LIMIT=-1
ENV COMPOSER_HOME=/etc/composer
ENV PHP_INI_SCAN_DIR='/etc/php82/conf.d:/etc/app/php'

RUN apk add --no-cache jq curl nano rsync git zip unzip cronie openssh libwebp libwebp-tools \
        php82 php82-apcu php82-fpm php82-bcmath php82-bz2 php82-exif php82-ctype php82-curl php82-dom php82-xml \
        php82-fileinfo php82-gd php82-gettext php82-iconv php82-intl php82-json php82-mbstring php82-mysqli \
        php82-openssl php82-pdo_mysql php82-phar php82-simplexml php82-soap php82-sockets php82-sodium php82-xdebug \
        php82-tokenizer php82-xmlwriter php82-xsl php82-zip php82-zlib php82-opcache php82-pecl-redis php82-pecl-vips \
    && ln -s /usr/sbin/php-fpm82 /usr/sbin/php-fpm \
    && ln -s /usr/bin/php82 /usr/bin/php \
    && crontab -u root -r \
    && chmod u+s /usr/sbin/crond

RUN addgroup -g 1000 -S app \
    && adduser -D -g app -u 1000 -S app -G app -h /app -s /bin/sh \
    && mkdir -p /etc/app/php \
    && chown -R app:app /app /var/log/php* /etc/app \
    && chmod -R 755 /app /etc/app

COPY --from=composer --chmod=755 /usr/bin/composer /usr/local/bin/composer
COPY --chown=root:root etc/php-fpm.d/ /etc/php82/php-fpm.d/
COPY --chown=app:app --chmod=777 etc/php-conf.d/ /etc/php82/conf.d/
COPY --chown=app:app etc/crontabs/app /etc/crontabs/app
COPY --chmod=755 bin/ /usr/local/sbin/

WORKDIR /app

USER app
