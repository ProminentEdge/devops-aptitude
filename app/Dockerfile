FROM ubuntu:18.04

MAINTAINER "Byron Mansfield - byron@byronmansfield.com"

LABEL maintainer="Byron Mansfield - byron@byronmansfield.com" \
      name="pe-interview" \
      description="PE DevOps Interview Flask App"

ENV PROJECT_NAME="flaskapp" \
    PORT=5000

WORKDIR /app

COPY . /app

RUN \
		# install linux packages
		apt-get update -y && \
		apt-get install -y \
						python-pip \
						python-dev \
						build-essential && \
    \
		# install python libraries
		pip install -r requirements.txt
