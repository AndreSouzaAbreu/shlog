#!/bin/sh

ASSETS_DIR=./assets
PUBLIC_DIR=./public

fhash=$(md5sum ${ASSETS_DIR}/app.css | awk '{ print $1 }')
find ${PUBLIC_DIR} -maxdepth 1 -type f -iname 'app*.css' -delete
cp ${ASSETS_DIR}/app.css ${PUBLIC_DIR}/app.${fhash}.css
sed -i "/href/s/app.*\.css/app.${fhash}.css/" ./template.html