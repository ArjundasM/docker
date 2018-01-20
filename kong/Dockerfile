#Dockerfile for install kong
FROM ubuntu:14.04

COPY kong/key /data/key

COPY kong/kong.conf /etc/kong/kong.conf

COPY kong/start-kong.sh /root/start-kong.sh

COPY kong/postgresql.list /etc/apt/sources.list.d

RUN apt-key add /data/key && \
    rm /data/key && \
    apt-get update && apt-get -y --no-install-recommends --force-yes install wget curl openssl libpcre3 procps perl postgresql-9.6 && \
    wget --no-check-certificate -O /data/kong-community-edition-0.11.1.trusty.all.deb https://bintray.com/kong/kong-community-edition-deb/download_file?file_path=dists/kong-community-edition-0.11.1.trusty.all.deb && \
    dpkg -i /data/kong-community-edition-0.11.1.trusty.all.deb && \
    service postgresql start && \
    sudo -u postgres bash -c "psql -c \"CREATE USER kong WITH PASSWORD 'kong';\"" && \
    sudo -u postgres bash -c "psql -c \"create database kong owner kong;\"" && \
    sed -i -e 's/peer/md5/g' /etc/postgresql/9.6/main/pg_hba.conf && \
    curl --insecure https://deb.nodesource.com/setup_9.x | bash  && \
    apt-get -y --no-install-recommends --force-yes install nodejs && \
    npm install -g kong-dashboard && \
    chmod +x /etc/kong/kong.conf && \
    service postgresql stop && \
    chmod +x /root/start-kong.sh

ENTRYPOINT ["/root/start-kong.sh"]

EXPOSE 16000

CMD ["bash"]
