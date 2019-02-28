FROM php:7.3-cli-alpine3.8

ENV PHP_DEPS="openssl-dev"

RUN apk add --no-cache --update --virtual .build-deps ${PHP_DEPS} \
    && curl -L https://github.com/humbug/box/releases/download/3.1.1/box.phar -o /usr/bin/box \
    && chmod +x /usr/bin/box \
    # Extensions required by humbug/box
    && docker-php-ext-install phar tokenizer \
    # Extensions required by SPHP services
    && docker-php-ext-install bcmath json mbstring pcntl \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

WORKDIR /app

ENTRYPOINT [ "box" ]
