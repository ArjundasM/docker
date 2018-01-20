# Dockerfile for instaling Bigbrain application

# Pull base image
FROM ubuntu:14.04

# Install oracle-java-8
RUN \
  apt-get update && \
  apt-get -y install software-properties-common python-software-properties && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

#Download Activemq

RUN mkdir /data && \
    wget -O  /data/activemq.tar.gz  http://apache.mirrors.ovh.net/ftp.apache.org/dist/activemq/5.13.5/apache-activemq-5.13.5-bin.tar.gz && \
    tar -xzf /data/activemq.tar.gz -C /data && \
    rm -rf /data/activemq.tar.gz && \
    cp /data/apache-activemq-5.13.5/bin/env /etc/default/activemq && \
    ln -s /data/apache-activemq-5.13.5/bin/activemq /etc/init.d/activemq && \
    update-rc.d activemq defaults

ENTRYPOINT service activemq start && tail -f /data/apache-activemq-5.13.5/data/activemq.log

EXPOSE 8161

CMD ["bash"]

