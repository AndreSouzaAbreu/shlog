#!/bin/sh

ASSETS_DIR=./assets
PUBLIC_DIR=./public

fhash=$(md5sum ${ASSETS_DIR}/app.css | awk '{ print $1 }')
cp ${ASSETS_DIR}/app.css ${PUBLIC_DIR}/app.${fhash}.css
sed -i "/href/s/app.*\.css/app.${fhash}.css/" ${ASSETS_DIR}/template.html
