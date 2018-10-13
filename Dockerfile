FROM php:7.1-cli-alpine

ENV PHP_DEPS="openssl-dev"

RUN apk add --no-cache --update --virtual .build-deps ${PHP_DEPS} \
    && curl -L https://github.com/humbug/box/releases/download/3.1.1/box.phar -o /usr/bin/box \
    && chmod +x /usr/bin/box \
    && docker-php-ext-install phar tokenizer \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

WORKDIR /app

ENTRYPOINT [ "box" ]