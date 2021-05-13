#!/usr/bin/env bash

set -e

echo "MAGENTO REMOVE CACHE AND STATIC CONTENT..."
rm -fr var/cache/* var/view/view_preprocessed/* var/page_cache/* generated/code/ pub/static/*
echo "MAGENTO GENERATE STATIC CONTENT..."
bin/magento s:s:d -f
echo "SETUP DI COMPILE..."
bin/magento s:d:c
echo "SETUP UPGRADE..."
bin/magento s:upgrade

echo "*********************** END web tasks ***********************"