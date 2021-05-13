#!/usr/bin/env bash

echo 'alias m2="bin/magento"' >> ~/.bash_aliases && \
curl -O https://files.magerun.net/n98-magerun2.phar && \
chmod +x ./n98-magerun2.phar && \
echo 'alias magerun="./n98-magerun2.phar"' >> ~/.bash_aliases && \
source ~/.bash_aliases

magerun config:env:set 'x-frame-options' '*'