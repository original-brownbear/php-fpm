#!/usr/bin/env bash

pkill php-fpm

if [ -f /usr/local/etc/php/conf.d/xdebug.ini ]
then
	echo "turning xdebug off..."
	mv /usr/local/etc/php/conf.d/xdebug.ini /root/.
else
	echo "activating xdebug..."
	mv /root/xdebug.ini /usr/local/etc/php/conf.d/ 
fi

php-fpm -R -D
