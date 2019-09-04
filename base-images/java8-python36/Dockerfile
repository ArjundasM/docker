#BASE IMAGE FOR JAVA8+PYTHON3.6
FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install openjdk-8-jdk python3.6 python3-pip -y && \
    pip3 install --upgrade pip
