ASSETS_DIR=assets
PUBLIC_DIR=public
SRC_DIR=src

build: html format

clean:
	-rm -rf ${PUBLIC_DIR}/*
	find ${SRC_DIR} -type f -iname 'index.md' -delete

format:
	find ${PUBLIC_DIR} -type f -iname "*.html" -exec vim -c "normal gg=G" -c "x" '{}' \;

html: html_template indexes
	./makehtml.sh

html_template: assets/app.css
	./maketemplate.sh

indexes:
	./makeindex.sh

live:
	./node_modules/.bin/browser-sync start --server ${PUBLIC_DIR} --files ${PUBLIC_DIR}

watch:
	find ${SRC_DIR} ${ASSETS_DIR} -type f | entr make html

.PHONY: build clean format html html_template indexes live watch
