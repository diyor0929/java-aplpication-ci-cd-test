# Stage 1: Build Dependencies
FROM php:8.4.1-fpm-alpine as build

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    git \
    unzip \
    curl \
    libzip-dev \
    oniguruma-dev \
    postgresql-dev \
    bash \
    && docker-php-ext-install pdo pdo_pgsql zip

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy app files and install dependencies
COPY . .
RUN composer install --no-dev --optimize-autoloader

# Stage 2: Runtime Environment
FROM php:8.4.1-fpm-alpine

# Install required PHP extensions
RUN apk add --no-cache \
    libzip-dev \
    oniguruma \
    postgresql-dev \
    bash \
    && docker-php-ext-install pdo pdo_pgsql zip

# Set working directory
WORKDIR /var/www/html

# Copy files from the build stage
COPY --from=build /var/www/html /var/www/html

# Copy entrypoint script (optional)
# COPY docker/entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Expose port (for php-fpm)
EXPOSE 9000

CMD ["php-fpm"]