Video Service

The main purpose is to collect videos and manage them.

How to run:

cd python-video-service

Docker docker build -t video_service .

docker run -p host_port:8086 -v host_folder:/home/root/video video_service

How to run locally:

requires python version >= 2.8.10

cd python-video-service

virtualenv .venv

source .venv/bin/activate

pip install -r requirements.txt

python main.py


Then just open browser and go to url: http://localhost:8086/login

default user and password is admin