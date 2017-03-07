FROM wwestenbrink/baseimage-ubuntu-12
MAINTAINER "D. Rimron Soutter" <darran@xalior.com>

ENV TERM xterm

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

RUN echo Europe/London | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get update && \
    apt-get install -y wget dialog net-tools curl git nginx php5-fpm php5-cli php5-mysql mysql-client php5-ldap

ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf
#
#RUN ln -sf /dev/stdout /var/log/nginx/access.log
#RUN ln -sf /dev/stderr /var/log/nginx/error.log
#

#
#ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#RUN chown root:root /etc/supervisor/conf.d/supervisord.conf
#

RUN mkdir -p /var/www/htdocs
ADD index.php /var/www/htdocs/index.php

RUN mkdir -p /etc/service/nginx
ADD runit/nginx /etc/service/nginx/run

EXPOSE 80
EXPOSE 443
