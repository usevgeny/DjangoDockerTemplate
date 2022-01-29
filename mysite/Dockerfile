ARG PYTHON_VERSION=3.7-slim-buster

# define an alias for the specfic python version used in this file.
FROM python:${PYTHON_VERSION} as python

# Python build stage
FROM python as python-build-stage

ARG BUILD_ENVIRONMENT=production

# Install apt packages
RUN apt-get update && apt-get install --no-install-recommends -y \
  # dependencies for building Python packages
  build-essential \
  # psycopg2 dependencies
  libpq-dev

# Requirements are installed here to ensure they will be cached.
COPY ./portfolio/requirements_postgres.txt ./home/

# Create Python Dependency and Sub-Dependency Wheels.
RUN pip wheel --wheel-dir /usr/src/app/wheels  \
  -r /home/requirements_postgres.txt


# Python 'run' stage
FROM python as python-run-stage

ARG BUILD_ENVIRONMENT=production
ARG APP_HOME=/home/app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV BUILD_ENV ${BUILD_ENVIRONMENT}

WORKDIR ${APP_HOME}

# Install required system dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
  # psycopg2 dependencies
  libpq-dev  apache2 libapache2-mod-wsgi-py3 netcat \
  # Translations dependencies
  gettext \
  # cleaning up unused files
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/*

# All absolute dir copies ignore workdir instruction. All relative dir copies are wrt to the workdir instruction
# copy python dependency wheels from python-build-stage
COPY --from=python-build-stage /usr/src/app/wheels  /wheels/

# use wheels to install python dependencies
RUN pip install --no-cache-dir --no-index --find-links=/wheels/ /wheels/* \
  && rm -rf /wheels/

RUN mkdir -p /home/app/
RUN mkdir -p /home/logs/
RUN mkdir -p /home/ssl/
#COPY ./app /home/app

COPY ./portfolio/wait.sh /wait.sh
RUN chmod +x /wait.sh

#preparing apache2

COPY ./apache_portfolio/appli.conf /etc/apache2/sites-available/000-default.conf
COPY ./apache_portfolio/apache2.conf /etc/apache2/apache2.conf
RUN  ln -s /home/app/portfolio/wsgi.py /var/www/app
RUN a2enmod rewrite
RUN a2enmod ssl
EXPOSE 80
#EXPOSE 8443