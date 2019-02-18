FROM alpine:3.8
MAINTAINER "Karmashkin" <vlad@zolotous.com>

RUN apk add --no-cache supervisor \
                       shadow \
                       git \
                       mariadb-client \
#                       openjdk8-jre-base \
#                       openjdk8 \
#                       tomcat-native \
                       bash

RUN addgroup -g 666 spring \
&& adduser -D -G spring -u 666 -h /home/spring -s /bin/bash spring

VOLUME ["/home/spring/src"]

EXPOSE 8080

ADD start.sh /
RUN chmod +x /start.sh

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk upgrade -U \
    && apk --update add gosu \
                        coreutils \
                        openjdk8 \
                        openjdk8-jre-base \
                        tomcat-native \
                        tomcat-native-dev \
    && ln -s /usr/bin/gosu /usr/local/bin/gosu

WORKDIR /home/spring/src

CMD ["/start.sh"]
