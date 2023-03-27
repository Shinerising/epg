# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

# Add the cron job
RUN echo '0 0 *  *  * python3 /app/main.py' > /etc/crontabs/root

CMD [ "python3", "manage.py", " runserver", "0.0.0.0:8080"]