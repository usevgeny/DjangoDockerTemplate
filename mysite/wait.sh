#!/bin/bash

while ! nc -z portfolio_db 5233 ; do
    echo "Waiting for the Postgres Server"
    sleep 3
done

#python manage.py runserver 0.0.0.0:8000
source /etc/apache2/envvars
#a2enmod rewrite
python /home/app/manage.py makemigrations
python /home/app/manage.py migrate
#python /home/app/manage.py shell < /home/initiating_dbs.py
/usr/sbin/apache2 -f /etc/apache2/apache2.conf -DFOREGROUND
