FROM ubuntu:18.10

RUN apt-get update; apt-get install -y git openjdk-11-jdk
RUN apt-get install -y locales 

## because this is Docker, we can just set these without bothering
## with most of the locale infrastructure
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV LC_CTYPE C.UTF-8

RUN mkdir -p /opt/codescene
RUN mkdir -p /codescene/analysis
RUN mkdir -p /codescene/repos
RUN mkdir -p /codescene/log

ARG CODESCENE_VERSION=3.0.5
ADD https://downloads.codescene.io/enterprise/${CODESCENE_VERSION}/codescene-enterprise-edition.standalone.jar /opt/codescene/
EXPOSE 3003

# separate script used because we want to support custom JAVA_OPTIONS variable
ADD start-codescene.sh /start-codescene.sh
RUN chmod 755 /start-codescene.sh

ENV CODESCENE_DB_PATH=/codescene
ENV CODESCENE_ANALYSIS_RESULTS_ROOT=/codescene/analysis
ENV CODESCENE_CLOSED_REPOSITORIES_ROOT=/codescene/repos

ENTRYPOINT [ "/start-codescene.sh" ]
