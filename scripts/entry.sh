#!/bin/bash
set -e

echo -e "Running PHP-FPM Daemon..."
php-fpm -D

RETRIES=30
until pg_isready -h $DB_HOST > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "Waiting for postgres server: $DB_HOST, $((RETRIES--)) remaining attempts..."
  sleep 1
done

echo -e "Running Nginx..."
/usr/sbin/nginx -g "daemon off;"