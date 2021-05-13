#!/usr/bin/env bash

#a2enmod rewrite
echo LoadModule rewrite_module modules/mod_rewrite.so >> /etc/httpd/conf.modules.d/00-base.conf