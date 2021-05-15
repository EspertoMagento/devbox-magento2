# install on centos 7
FROM centos:7

LABEL version="1.0"
LABEL maintainer="danycrup@gmail.com"

ENV MAGENTO_VERSION 2.4.2
ENV INSTALL_DIR /var/www/html
ENV COMPOSER_HOME /var/www/.composer/
ENV APACHE_USER www-data
ENV APACHE_GROUP apache
ENV PROJECT_HOST local.magento

# add user to apache
RUN adduser -u 501 -s /bin/bash -M -d $INSTALL_DIR/ -p password www-data
RUN groupadd -g 48 apache
RUN usermod -a -G apache www-data

# install docker
# RUN yum -y update \
# && yum -y install docker \
# && systemctl enable docker.service \
# && systemctl start docker.service

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    https://rpms.remirepo.net/enterprise/remi-release-7.rpm

# install apache
RUN yum -y --setopt=tsflags=nodocs install httpd \
    && mkdir /etc/httpd/sites-available /etc/httpd/sites-enabled \
    && echo 'IncludeOptional sites-enabled/*.conf' >> /etc/httpd/conf/httpd.conf \
    && sed -i 's/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

# install php7.4 and other utility
RUN yum -y --setopt=tsflags=nodocs update \
    && yum-config-manager --enable remi-php74 \
    && yum -y --setopt=tsflags=nodocs install \
    yum-utils \
    git \
    curl \
    openssl \
    mod_ssl \
    wget \
    unzip \
    php \
    php-common \
    php-cli \
    php-curl \
    php-dev \
    php-gd \
    php-intl \
    php-mysql \
    php-mbstring \
    php-xml \
    php-xsl \
    php-zip \
    php-json \
    php-xdebug \
    php-soap \
    php-bcmath \
    php-imagick	\
    php-exif	\
    php-opcache	\
    php-bcmath \
    php-ctype \
    php-dom \
    php-iconv \
    php-sockets \
    zip \
    mysql-client \
    && yum clean all \
    && rm -rf \   
    /tmp/* \
    /var/tmp/*


# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && /usr/local/bin/composer self-update --1
COPY ./auth.json $COMPOSER_HOME
RUN chmod -R 777 $COMPOSER_HOME && chown -R $APACHE_USER:$APACHE_GROUP $COMPOSER_HOME


WORKDIR $INSTALL_DIR

# copy Magento directory
#COPY magento2 .
#ADD magento2.tar.gz .

RUN chown -R $APACHE_USER:$APACHE_GROUP .

EXPOSE 80 443

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

COPY ./install-magento /usr/local/bin/install-magento
RUN chmod +x /usr/local/bin/install-magento

COPY ./install-sampledata /usr/local/bin/install-sampledata
RUN chmod +x /usr/local/bin/install-sampledata

#RUN chown -R /usr/local/bin/

# certificate ssl
RUN mkdir /etc/ssl/private && chmod 700 /etc/ssl/private
#RUN make-ssl-cert generate-default-snakeoil --force-overwrite
COPY ./config/apache/certs/example.key /etc/ssl/private/
COPY ./config/apache/certs/example.crt /etc/ssl/certs/
RUN chmod 600 /etc/ssl/certs/example.crt && chmod 600 /etc/ssl/private/example.key

RUN sed -i 's/#DocumentRoot/DocumentRoot/g' /etc/httpd/conf.d/ssl.conf \
    && sed -i 's/#ServerName/ServerName/g' /etc/httpd/conf.d/ssl.conf \
    && sed -i 's/example.com/$PROJECT_HOST/g' /etc/httpd/conf.d/ssl.conf \
    && sed -i 's/var\/www\/html/var\/www\/html\/pub/g' /etc/httpd/conf.d/ssl.conf

RUN sed -i 's/memory_limit = 128M/memory_limit = 2048M/g' /etc/php.ini

# Add cron job
RUN yum -y install cronie

ADD crontab /etc/cron.d/magento2-cron
RUN chmod 644 /etc/cron.d/magento2-cron \
    && crontab -u $APACHE_USER /etc/cron.d/magento2-cron

CMD ["/bin/bash", "/run-httpd.sh"]
