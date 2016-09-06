FROM python:2-onbuild

EXPOSE 8086

USER root

CMD [ "python", "generate_conf.py" ]
CMD [ "python", "main.py" ]