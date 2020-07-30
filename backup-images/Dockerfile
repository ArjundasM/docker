FROM ubuntu:latest

RUN apt update && apt install mysql-client s3cmd ca-certificates -y

COPY s3cfg /root/.s3cfg
