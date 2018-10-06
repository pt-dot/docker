FROM mysql:5.7

MAINTAINER Samsul Ma'arif <samsul@blankon.id>

ENV MYSQL_DATABASE=thedb \
    MYSQL_ROOT_PASSWORD=strongpassword

EXPOSE 3306
