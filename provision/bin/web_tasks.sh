#!/usr/bin/env bash

set -e

#Set permissions
echo "RESET MAGENTO PERMISSIONS..."
cd /var/www/html/
find . -type f -exec chmod 644 {} +
find . -type d -exec chmod 755 {} +
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chown -R $UID:$GID .
chmod u+x bin/magento
chmod +x ./n98-magerun2.phar
find . -name ".DS_Store" -exec rm -fr {} \;

echo "*********************** END web tasks ***********************"
