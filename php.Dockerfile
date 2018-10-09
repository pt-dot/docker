FROM php:7.0-apache

MAINTAINER Samsul Ma'arif <samsul@dot-indonesia.com>

ENV USERID=1000
ENV GRPID=1000

COPY ./docker/php.ini /usr/local/etc/php
RUN apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev \
 libpng-dev libmcrypt-dev mysql-client libcurl3-dev libicu-dev libxml2-dev libbz2-dev zip unzip 	
RUN docker-php-ext-install mbstring mysqli pdo_mysql curl json intl gd xml zip bz2 opcache

COPY ./docker/myapp.conf /etc/apache2/sites-available/000-default.conf
COPY ./docker/apache2.conf /etc/apache2/apache2.conf
COPY ./docker/ports.conf /etc/apache2/ports.conf

RUN usermod -s /bin/bash www-data && \
   mkdir /app && \
   usermod -d /app www-data && \
   groupmod -g $GRPID www-data && \
   usermod -u $USERID -g $GRPID www-data && \
   chown -Rf www-data.www-data /var/run/apache2 && \
   chown -Rf www-data.www-data /var/log/apache2

RUN a2enmod rewrite && \
   service apache2 restart

# install composer
RUN curl -sS https://getcomposer.org/installer | php && \
   mv composer.phar /usr/bin/composer

# cleanup
RUN rm -rf /var/cache/apt/archives/* && rm -rf /tmp/*

EXPOSE 8000

WORKDIR /app

USER www-data:www-data
