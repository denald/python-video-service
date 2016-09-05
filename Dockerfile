FROM python:2-onbuild

EXPOSE 8086

USER root

CMD [ "python", "video_service.py" ]