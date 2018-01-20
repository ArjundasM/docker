# Dockerfile for instaling Bigbrain application
FROM ubuntu:14.04

RUN apt-get update && apt-get -y --no-install-recommends --force-yes install wget && \
    mkdir -p /opt/jdk && \
    wget --no-cookies --no-check-certificate --header \
                     "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
                     "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz" && \
    tar -xvzf jdk-8u161-linux-x64.tar.gz && \
    mv jdk1.8.0_161/* /opt/jdk/ && \
    rm -rf jdk1.8.0_161 jdk-8u161-linux-x64.tar.gz && \
    update-alternatives --install /usr/bin/java java /opt/jdk/bin/java 100 && \
    update-alternatives --install /usr/bin/jps jps /opt/jdk/bin/jps 100 && \
    rm -rf /opt/jdk/*src.zip \
           /opt/jdk/lib/missioncontrol \
           /opt/jdk/lib/visualvm \
           /opt/jdk/lib/*javafx* \
           /opt/jdk/jre/lib/plugin.jar \
           /opt/jdk/jre/lib/ext/jfxrt.jar \
           /opt/jdk/jre/bin/javaws \
           /opt/jdk/jre/lib/javaws.jar \
           /opt/jdk/jre/lib/desktop \
           /opt/jdk/jre/plugin \
           /opt/jdk/jre/lib/deploy* \
           /opt/jdk/jre/lib/*javafx* \
           /opt/jdk/jre/lib/*jfx* \
           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
           /opt/jdk/jre/lib/amd64/libprism_*.so \
           /opt/jdk/jre/lib/amd64/libfxplugins.so \
           /opt/jdk/jre/lib/amd64/libglass.so \
           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jdk/jre/lib/amd64/libjavafx*.so \
           /opt/jdk/jre/lib/amd64/libjfx*.so && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /opt/jdk

CMD ["bash"]

