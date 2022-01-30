#!/bin/bash

while ! nc -z mysite_db 5233 ; do
    echo "Waiting for the Postgres Server"
    sleep 3
done


source /etc/apache2/envvars
#a2enmod rewrite
python /home/app/manage.py makemigrations
python /home/app/manage.py migrate

/usr/sbin/apache2 -f /etc/apache2/apache2.conf -DFOREGROUND
