FROM python:3.9

COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

WORKDIR /app
COPY . /app
EXPOSE 8080
CMD uvicorn main:app --host=0.0.0.0 --port=$PORT
