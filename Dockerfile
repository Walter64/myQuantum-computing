# # syntax=docker/dockerfile:1
# FROM python:3.7-alpine
# WORKDIR /code
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0
# RUN apk add --no-cache gcc musl-dev linux-headers
# COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt
# EXPOSE 5000
# COPY . .
# CMD ["flask", "run"]


# syntax=docker/dockerfile:1 for jupyter notebook
# jupyter/scipy-notebook as base image
# sets working folder to /home/jovyan/repo
# copies requirements.txt in there
# runs pip install for requirements.txt packages
# explicitly states port 8888 is exposed
FROM jupyter/scipy-notebook
WORKDIR /home/jovyan/repo
USER root
RUN apt update && apt-get -y upgrade && apt -y install git
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 8888