FROM php:8.4-fpm-alpine AS builder

RUN apk add --no-cache \
    git \
    unzip \
    libpq-dev \
    oniguruma-dev \
    icu-dev

RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    mbstring \
    intl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# 🔥 FAQAT composer fayllar
COPY composer.json composer.lock ./

# 🔥 TOZA PROD INSTALL
RUN composer install \
    --no-dev \
    --no-scripts \
    --no-interaction \
    --prefer-dist

# 🔥 KEYIN LARAVEL KOD
COPY . .

# 🔥 SCRIPT’LARNI ENDI ISHLATAMIZ
RUN composer dump-autoload --optimize \
 && php artisan package:discover --ansi


############################
# Runtime
############################
FROM php:8.4-fpm-alpine

RUN apk add --no-cache \
    libpq \
    oniguruma \
    icu

WORKDIR /var/www

COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
COPY --from=builder /var/www /var/www

RUN chown -R www-data:www-data /var/www \
 && chmod -R 775 storage bootstrap/cache

USER www-data

CMD ["php-fpm"]
