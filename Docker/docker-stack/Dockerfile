FROM python:latest

WORKDIR /app

COPY . /app

RUN python -m pip install --upgrade pip
RUN pip install flask redis

EXPOSE 80

ENV NAME World

CMD ["python","app.py"]