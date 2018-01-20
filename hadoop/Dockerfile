#Dockerfile for hadoop
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

RUN apt-get update && apt-get install -y --force-yes openssh-server && \
    mkdir /data && \
    wget https://archive.apache.org/dist/hadoop/core/hadoop-2.6.0/hadoop-2.6.0.tar.gz && \
    tar -xzf hadoop-2.6.0.tar.gz -C /data && \
    rm -rf hadoop-2.6.0.tar.gz && \
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N '' -P "" && \
    touch ~/.ssh/authorized_keys && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    echo 'Host * \n\
              StrictHostKeyChecking no \n\
              UserKnownHostsFile=/dev/null' > ~/.ssh/config && \
    mkdir -p /data/hdfs/namenode && \ 
    mkdir -p /data/hdfs/datanode && \
    mkdir -p /data/hdfs/tmp 

ENV HADOOP_HOME=/data/hadoop-2.6.0 
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native"
ENV CLASSPATH=$CLASSPATH:/usr/local/hadoop/lib/*:.
ENV HADOOP_OPTS="$HADOOP_OPTS -Djava.security.egd=file:/data/hadoop-2.6.0/temp/tmp"
 
RUN echo '<?xml version="1.0"?> \n\
             <configuration> \n\
               <property> \n\
                 <name>hadoop.tmp.dir</name> \n\
                 <value>/data/hdfs/tmp</value> \n\
               </property> \n\
               <property> \n\
                 <name>fs.default.name</name> \n\
                 <value>hdfs://localhost:9000/</value> \n\
               </property> \n\
             </configuration>' > ${HADOOP_HOME}/etc/hadoop/core-site.xml

RUN echo '<?xml version="1.0"?> \n\
            <configuration> \n\
              <property> \n\
                <name>dfs.namenode.name.dir</name> \n\
                <value>file:/data/hdfs/namenode</value> \n\
              </property> \n\
              <property> \n\
                <name>dfs.datanode.data.dir</name> \n\
                <value>file:/data/hdfs/datanode</value> \n\
              </property> \n\
              <property> \n\
                <name>dfs.replication</name> \n\
                <value>2</value> \n\
              </property> \n\
	      <property> \n\
       		<name>dfs.webhdfs.enabled</name> \n\
       		<value>true</value> \n\
	      </property> \n\
 	      <property> \n\
        	<name>dfs.client.use.datanode.hostname</name> \n\
              <value>true</value> \n\
	      </property> \n\
            </configuration>' > ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml

RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle \n\
	  export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/etc/hadoop"} \n\
	  for f in $HADOOP_HOME/contrib/capacity-scheduler/*.jar; do \n\
	    if [ "$HADOOP_CLASSPATH" ]; then \n\
	      export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$f \n\
	    else \n\
	      export HADOOP_CLASSPATH=$f \n\
	    fi \n\
	  done \n\
	  export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true" \n\
	  export HADOOP_NAMENODE_OPTS="-Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_NAMENODE_OPTS" \n\
	  export HADOOP_DATANODE_OPTS="-Dhadoop.security.logger=ERROR,RFAS $HADOOP_DATANODE_OPTS" \n\
	  export HADOOP_SECONDARYNAMENODE_OPTS="-Dhadoop.security.logger=${HADOOP_SECURITY_LOGGER:-INFO,RFAS} -Dhdfs.audit.logger=${HDFS_AUDIT_LOGGER:-INFO,NullAppender} $HADOOP_SECONDARYNAMENODE_OPTS" \n\
	  export HADOOP_NFS3_OPTS="$HADOOP_NFS3_OPTS" \n\ 
	  export HADOOP_PORTMAP_OPTS="-Xmx512m $HADOOP_PORTMAP_OPTS" \n\
	  export HADOOP_CLIENT_OPTS="-Xmx512m $HADOOP_CLIENT_OPTS" \n\
	  export HADOOP_SECURE_DN_USER=${HADOOP_SECURE_DN_USER} \n\
	  export HADOOP_SECURE_DN_LOG_DIR=${HADOOP_LOG_DIR}/${HADOOP_HDFS_USER} \n\
	  export HADOOP_PID_DIR=${HADOOP_PID_DIR} \n\
	  export HADOOP_SECURE_DN_PID_DIR=${HADOOP_PID_DIR} \n\
	  export HADOOP_IDENT_STRING=$USER' > ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

RUN echo "#!/bin/bash \n\
    service ssh start \n\
    /data/hadoop-2.6.0/bin/hdfs namenode -format \n\
    /data/hadoop-2.6.0/sbin/start-dfs.sh \n\ 
    while true; do sleep 1000; done" > /root/start-master.sh && \
    chmod +x /root/start-master.sh

EXPOSE 50070

ENTRYPOINT ["/root/start-master.sh"]

CMD ["bash"]
