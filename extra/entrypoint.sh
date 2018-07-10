#!/bin/bash

sed -i "s|__DESTINATION__|${DESTINATION}|" /etc/apache2/sites-available/*.conf

if [ "$ENABLE_HTTPS" -eq "1" ]; then
    a2ensite rumrevproxy-ssl
fi

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_LOG_DIR=/var/log/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_PID_FILE=/var/run/apache2.pid

/usr/sbin/apache2ctl -D FOREGROUND
