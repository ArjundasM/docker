#Dockerfile to install python3.5
FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y \
                    wget \
                    xz-utils \
                    build-essential \
                    libsqlite3-dev \
                    libreadline-dev \
                    libssl-dev \
                    openssl
                        
WORKDIR /tmp

RUN wget https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tar.xz && \
    tar -xf Python-3.5.3.tar.xz

WORKDIR /tmp/Python-3.5.3

RUN ./configure && \
    make && \
    make install

RUN apt-get update && \
    apt-get -y install python3-pip && \
    pip3 install --upgrade pip


WORKDIR /

RUN wget http://downloads.razorthink.net/bigbrain/py-libs/rztdl-0.1.2-py3-none-any.whl && \
    wget http://downloads.razorthink.net/bigbrain/py-libs/bbcliutils-0.1-py2.py3-none-any.whl && \
    pip3.5 install rztdl-0.1.2-py3-none-any.whl && \
    pip3.5 install bbcliutils-0.1-py2.py3-none-any.whl 

RUN rm -rf /tmp/Python-3.5.0.tar.xz /tmp/Python-3.5.3


