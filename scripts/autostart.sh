#!/bin/bash
if [ ! -f "/var/www/html/xdebug.log" ]; then
	touch /var/www/html/xdebug.log
else
	echo | tee /var/www/html/xdebug.log
fi

apache2-foreground &
/usr/sbin/sshd -D
