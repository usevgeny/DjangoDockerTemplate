This is a template of a dockerized Django project. 

.env file contains environment variables, used by Django and by Postgres and should be changed for your project.

docker-compose.yml: lines #6, #8, #10,#21, #24: 'mysite'
 is to be changed according to your django project name.

same for ./mysite/Dockerfile: lines #19,#61,#68
and ./apache/appli.conf: lines #30, #35

to run docker with your django project use:

'docker-compose -f docker-compose.yml up --build'

on the first run you need to set up a superuser 
for this:

1) run "docker exec -it django_docker_template_mysite_1 bash"
(where django_docker_template_mysite_1 is your container with django  app)
2) in container run "python manage.py createsuperuser"
3) follow the instructionsa and get your superuser created )

Then you need to colletc static files (scripts and css files):
1) run python manage.py collectstatic
this will create 'static' folder in your project root directory with all existing style-sheets and scrips


