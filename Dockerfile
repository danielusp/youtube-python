FROM python:3.9.7-slim

WORKDIR /usr/src/app
COPY . .

RUN pip install -r requirements.txt

#RUN pip install --no-cache-dir requests gspread oauth2client python-dotenv pandas aiohttp
