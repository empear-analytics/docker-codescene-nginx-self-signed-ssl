FROM ubuntu:18.04

RUN apt-get update; apt-get install -y git openjdk-8-jre
RUN apt-get install -y locales 

## because this is Docker, we can just set these without bothering
## with most of the locale infrastructure
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV LC_CTYPE C.UTF-8

RUN mkdir -p /opt/codescene

ARG CODESCENE_VERSION=2.8.0
ADD https://downloads.codescene.io/enterprise/${CODESCENE_VERSION}/codescene-enterprise-edition.standalone.jar /opt/codescene/
EXPOSE 3003

# separate script used because we want to support custom JAVA_OPTIONS variable
ADD start-codescene.sh /start-codescene.sh
RUN chmod 755 /start-codescene.sh
ENTRYPOINT [ "/start-codescene.sh" ]
