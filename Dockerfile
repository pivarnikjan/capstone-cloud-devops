FROM python:3.7.3-stretch

WORKDIR /app
COPY . /app

# hadolint ignore=DL3013
RUN pip3 install --upgrade pip &&\
		pip3 install -r requirements.txt

EXPOSE 5000

CMD ["python3", "src/node.py"]
