#!/bin/bash

### 20-m1-build-test.sh: checks to ensure the build was successful.


logvalue "Installing Magento"

cd ${BUILD_DIR}

chmod 777 .
mkdir -p ${BUILD_DIR}/pub/media
chmod -R 777 ${BUILD_DIR}/pub/media
chmod +x bin/magento

rsync_cmd="rsync --recursive --copy-links --specials --exclude='.git/' --exclude='.gitignore' --exclude='*README*'  -v --stats --progress "
if [[ -d "${CHECKOUT_DIR}/home/override" ]]; then
  ${rsync_cmd} ${CHECKOUT_DIR}/home/override/* ${BUILD_DIR}
  rm -rf ${BUILD_DIR}/pub/override
fi

${MAGENTO_CMD} setup:install \
    --admin-firstname="Magento" \
    --admin-lastname="Builder" \
    --admin-email="joseph@swiftotter.com" \
    --admin-user="ilyass" \
    --admin-password="admin11" \
    --db-name="build_db" \
    --db-user="login-user" \
    --db-password="root" \
    --db-host="127.0.0.1"
