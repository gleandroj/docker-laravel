#!/bin/bash
set -e

echo -e "Running PHP-FPM Daemon..."
php-fpm -D

echo -e "Running Nginx..."
/usr/sbin/nginx -g "daemon off;"