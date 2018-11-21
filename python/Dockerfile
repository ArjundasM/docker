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

#RUN rm -rf /tmp/Python-3.5.0.tar.xz /tmp/Python-3.5.3


