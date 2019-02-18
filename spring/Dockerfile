#FROM alpine:3.8
FROM openjdk:8u191-alpine3.9

MAINTAINER "Karmashkin" <vlad@zolotous.com>

RUN apk add --no-cache supervisor \
                       shadow \
                       git \
                       mariadb-client \
#                       openjdk8 \
#                       tomcat-native \
                       bash

RUN addgroup -g 666 spring \
&& adduser -D -G spring -u 666 -h /home/spring -s /bin/bash spring

RUN apk --update add gosu coreutils --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing --allow-untrusted \
    && ln -s /usr/bin/gosu /usr/local/bin/gosu

RUN apk --update add maven --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community --allow-untrusted

VOLUME ["/home/spring/src"]

ADD start.sh /
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
