#!/usr/bin/env bash

cd /
service sendmail start
chmod -R 777 /webgrind
php-fpm -R &
tail -f /dev/null
