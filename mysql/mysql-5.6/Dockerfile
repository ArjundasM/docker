#Dockerfile for mysql-server-5.6
FROM ubuntu:14.04

ARG ROOTPASSWD=root

RUN apt-get update && \
    apt-get install -y --force-yes debconf-utils && \
    echo "mysql-server-5.6 mysql-server/root_password password ${ROOTPASSWD}" | debconf-set-selections && \
    echo "mysql-server-5.6 mysql-server/root_password_again password ${ROOTPASSWD}" | debconf-set-selections && \
    #debconf-set-selections <<< 'mysql-server mysql-server-5.6/root_password password ${ROOTPASSWD}' && \
    #debconf-set-selections <<< 'mysql-server mysql-server-5.6/root_password_again password ${ROOTPASSWD}' && \
    apt-get -y install mysql-server-5.6

ENTRYPOINT service mysql start && tail -f /var/log/mysql/error.log

CMD ["bash"]

