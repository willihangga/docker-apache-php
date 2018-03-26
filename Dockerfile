FROM ubuntu:14.04
MAINTAINER Willih Angga <willih@domainesia.com>

RUN locale-gen en_US.UTF-8
RUN export LANG=en_US.UTF-8

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Add APT repo
RUN apt-get update
RUN apt-get install -yy software-properties-common python-software-properties
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get -y --force-yes upgrade

# Basic Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install python-setuptools curl git unzip vim-tiny
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install mysql-server mysql-client apache2 libapache2-mod-php7.2 php7.2-mysql php-apc

# Install PHP7 with Xdebug (dev environment)
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install php7.2 php7.2-curl php7.2-bcmath php7.2-bz2 php7.2-dev php7.2-gd php7.2-dom php7.2-imap php7.2-imagick php7.2-intl php7.2-json php7.2-ldap php7.2-mbstring php7.2-oauth php7.2-odbc php7.2-uploadprogress php7.2-ssh2 php7.2-xml php7.2-zip php7.2-solr php7.2-apcu php7.2-opcache php7.2-memcache php7.2-memcached mcrypt php7.0-mcrypt php-pear

# Mail function
RUN DEBIAN_FRONTEND=noninteractive pear install Mail Net_SMTP Auth_SASL Mail_Mime

# mysql config
ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf

# apache config
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN chown -R www-data:www-data /var/www/

# php config
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php/7.2/apache2/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php/7.2/apache2/php.ini
RUN sed -i -e "s/short_open_tag\s*=\s*Off/short_open_tag = On/g" /etc/php/7.2/apache2/php.ini
RUN sed -i -e 's/;opcache.enable/opcache.enable/' /etc/php/7.2/apache2/php.ini

# fix mod_rewrite
RUN /usr/sbin/a2enmod rewrite
RUN curl -o /etc/apache2/apache2.conf https://raw.githubusercontent.com/willihangga/docker-apache-php/master/apache2.conf

# Supervisor Config
RUN mkdir /var/log/supervisor/
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout
ADD ./supervisord.conf /etc/supervisord.conf

# Initialization Startup Script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 3306
EXPOSE 80

# volume to preserve files
VOLUME ["/var/lib/mysql"]

CMD ["/bin/bash", "/start.sh"]
