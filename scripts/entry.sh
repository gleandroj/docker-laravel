#!/bin/bash
set -e

#Start PHP-FPM
echo -e "Running PHP-FPM Daemon..."
php-fpm -D

#Wait for database
RETRIES=30
until pg_isready -h $DB_HOST > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "Waiting for postgres server: $DB_HOST, $((RETRIES--)) remaining attempts..."
  sleep 1
done

#Create Folders
mkdir -p /var/www/html/storage/app
mkdir -p /var/www/html/storage/framework/cache
mkdir -p /var/www/html/storage/framework/sessions
mkdir -p /var/www/html/storage/framework/testing
mkdir -p /var/www/html/storage/framework/views
mkdir -p /var/www/html/storage/logs

#Running Migration and Seeding
php /var/www/html/artisan config:clear 
php artisan auth:keys 
php artisan migrate --seed --force

#Starting Nginx
echo -e "Running Nginx..."
/usr/sbin/nginx -g "daemon off;"