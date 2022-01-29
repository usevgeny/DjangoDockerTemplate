"""
WSGI config for mysite project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/howto/deployment/wsgi/
"""

import os
import sys


#find where django is installed
PACKAGESPATH=os.popen('pip show django|sed -rn "/Location/p"|cut -f 2 -d " "').read().rstrip()

# add the virtualenv site-packages path to the sys.path
sys.path.append(f'{PACKAGESPATH}')
sys.path.append('/home/app')
sys.path.append('/home/app/mysite')


from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')

application = get_wsgi_application()
