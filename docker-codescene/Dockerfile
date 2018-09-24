FROM debian:9


RUN apt-get update; apt-get install -y git openjdk-8-jre
RUN apt-get install -y locales -qq && locale-gen en_US.UTF-8 en_us && dpkg-reconfigure locales && dpkg-reconfigure locales && locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV LC_CTYPE=C.UTF-8

RUN mkdir -p /opt/codescene
RUN mkdir -p /analysis

VOLUME /repos

ARG CODESCENE_VERSION=2.6.5
ADD https://downloads.codescene.io/enterprise/${CODESCENE_VERSION}/codescene-enterprise-edition.standalone.jar /opt/codescene/
EXPOSE 3003
# separate script used because we want to support custom JAVA_OPTIONS variable
ADD start-codescene.sh /start-codescene.sh
RUN chmod 755 /start-codescene.sh
ENTRYPOINT [ "/start-codescene.sh" ]
