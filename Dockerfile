FROM ubuntu:16.04

# Install Python

RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update -qqy \
  && DEBIAN_FRONTEND=noninteractive apt-get -qqy install software-properties-common python-software-properties \
  && DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:djcj/hybrid \
  && apt-get -qqy install ffmpeg


EXPOSE 8086

USER root

WORKDIR /home/root/

COPY . /home/root

RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "main.py" ]


