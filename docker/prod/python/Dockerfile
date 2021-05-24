FROM python:3.8.0

RUN ls -la
COPY ./backend /backend

WORKDIR /backend
# RUN ls
RUN pip install -r requirements/prod.txt
# EXPOSE 8000
CMD python manage.py makemigrations
CMD python manage.py migrate
CMD python manage.py runserver 0.0.0.0:8000
