#Dockerfile for Spark 
FROM ubuntu:14.04

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

RUN apt-get update && \
    mkdir /data && \
    mkdir /data/libs && \
    chmod +x /data/libs && \
    chown -R root:root /data && \
    apt-get install -y --force-yes openssh-server && \
    wget https://archive.apache.org/dist/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz && \
    tar -xzf spark-2.1.0-bin-hadoop2.7.tgz -C /data && \ 
    mv /data/spark-2.1.0-bin-hadoop2.7 /data/spark-2.1.0

ENV SPARK_HOME /data/spark-2.1.0
ENV PYSPARK_PYTHON python3
ENV PYTHONPATH $SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$SPARK_HOME/python/lib/pyspark.zip

RUN cp /data/spark-2.1.0/conf/spark-env.sh.template /data/spark-2.1.0/conf/spark-env.sh && \
    cp /data/spark-2.1.0/conf/spark-defaults.conf.template /data/spark-2.1.0/conf/spark-defaults.conf && \
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N '' -P "" && \
    touch ~/.ssh/authorized_keys && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    echo 'Host * \n\
              StrictHostKeyChecking no \n\
              UserKnownHostsFile=/dev/null' > ~/.ssh/config

RUN echo '#!/usr/bin/env bash \n\
	 SPARK_MASTER_HOST=localhost \n\
	 SPARK_LOCAL_IP=localhost' > /data/spark-2.1.0/conf/spark-env.sh

#RUN echo 'spark.driver.extraClassPath /data/libs/* \n\
#	  spark.executor.extraClassPath /data/libs/* \n\
#	  spark.master spark://localhost:7077' > /data/spark-2.1.0/conf/spark-defaults.conf

#COPY libs/* /data/libs/

RUN echo "#!/bin/bash \n\
    service ssh start \n\
    /data/spark-2.1.0/sbin/start-all.sh \n\
    while true; do sleep 1000; done" > /root/start-master.sh && \
    chmod +x /root/start-master.sh

EXPOSE 8080

ENTRYPOINT ["/root/start-master.sh"]

CMD ["bash"]


