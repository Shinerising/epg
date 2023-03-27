# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

# Adding crontab to the appropriate location
RUN echo '0 */6 * * * cd /app & python3 main.py' > /etc/cron.d/run-crawler

# Giving executable permission to crontab file
RUN chmod 0644 /etc/cron.d/run-crawler

# Running crontab
RUN crontab /etc/cron.d/run-crawler

CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8080"]
