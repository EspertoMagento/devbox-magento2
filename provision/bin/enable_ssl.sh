#!/usr/bin/env bash

#a2enmod ssl
#yum -y install mod_ssl
echo LoadModule ssl_module modules/mod_ssl.so >> /etc/httpd/conf.modules.d/00-ssl.conf