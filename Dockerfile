#
# Zookeeper server Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV ZOOKEEPER_VERSION=3.7.1

RUN apt-get update && apt-get install -y wget openjdk-11-jdk-headless

RUN wget https://www-eu.apache.org/dist/zookeeper/stable/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz && \
    tar -xzf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz && rm apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz && \
    useradd --system --home-dir /var/lib/zookeeper zookeeper && \
    mkdir -p /var/lib/zookeeper && mv apache-zookeeper-${ZOOKEEPER_VERSION}-bin /var/lib/zookeeper

RUN ls /var/lib/zookeeper/

ENV PATH=$PATH:/var/lib/zookeeper/apache-zookeeper-${ZOOKEEPER_VERSION}-bin/bin

COPY zoo.cfg /var/lib/zookeeper/apache-zookeeper-${ZOOKEEPER_VERSION}-bin/conf/zoo.cfg

WORKDIR /var/lib/zookeeper/apache-zookeeper-${ZOOKEEPER_VERSION}-bin
EXPOSE 2181 2888 3888

CMD [ "zkServer.sh", "start-foreground" ]
