FROM mysql:5.7

MAINTAINER Samsul Ma'arif <samsul@blankon.id>

ENV USERID=1000 \
    GRPID=1000

ENV MYSQL_DATABASE=thedb \
    MYSQL_ROOT_PASSWORD=strongpassword

RUN groupmod -g $GRPID mysql && \
   usermod -u $USERID -g $GRPID mysql

EXPOSE 3306
