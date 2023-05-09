FROM python:3.9.7-slim

WORKDIR /usr/src/app
COPY . .

RUN apt update && apt install ffmpeg -y
RUN pip install -r requirements.txt
