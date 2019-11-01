FROM ubuntu:18.10

# To workaround git authentication issues with libcurl 7.61.0 installed with 18.10
# Azure DevOps clone fails with personal access tokens -> see https://github.com/Microsoft/Git-Credential-Manager-for-Mac-and-Linux/issues/102
RUN echo "deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted" >> /etc/apt/sources.list

RUN apt-get update; apt-get install -y git openjdk-11-jdk locales libcurl3-gnutls=7.58.0*

# debugging utilities
RUN apt-get install -y netcat rlwrap

## because this is Docker, we can just set these without bothering
## with most of the locale infrastructure
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV LC_CTYPE C.UTF-8

RUN mkdir -p /opt/codescene

ARG CODESCENE_VERSION=3.4.5
ADD https://downloads.codescene.io/enterprise/${CODESCENE_VERSION}/codescene-enterprise-edition.standalone.jar /opt/codescene/
EXPOSE 3003

# separate script used because we want to support custom JAVA_OPTIONS variable
ADD start-codescene.sh /start-codescene.sh
RUN chmod 755 /start-codescene.sh

ENV CODESCENE_DIR /codescene
ENV CODESCENE_DB_PATH=${CODESCENE_DIR}/codescene
ENV CODESCENE_ANALYSIS_RESULTS_ROOT=${CODESCENE_DIR}/analysis
ENV CODESCENE_CLONED_REPOSITORIES_ROOT=${CODESCENE_DIR}/repos
ENV CODESCENE_TIMEZONE UTC

ENTRYPOINT [ "/start-codescene.sh" ]
