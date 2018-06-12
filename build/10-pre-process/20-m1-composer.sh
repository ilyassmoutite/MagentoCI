#!/bin/bash

### 10-composer.sh: this file installs the composer dependencies and the base Magento system

logvalue "Installing composer dependencies"

if [ -f "${CHECKOUT_DIR}/composer.json" ]; then
    logvalue "Executing composer install"
    (
          cd ${CHECKOUT_DIR} && $PHP /usr/local/bin/composer install --ignore-platform-reqs --no-interaction --no-plugins --no-dev  --no-progress --no-suggest --prefer-dist --optimize-autoloader &&
          $PHP /usr/local/bin/composer run-script post-install-cmd -vvv -- --redeploy -n
    )
fi
