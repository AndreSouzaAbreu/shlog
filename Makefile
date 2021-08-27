include .env

build: html format

clean:
	find ${SRC_DIR} -type f -iname 'index.md' -delete
	find ${PUBLIC_DIR} ! -iname 'storage' ! -iwholename ${PUBLIC_DIR} -delete
	-rm Makefile2

format:
	find ${PUBLIC_DIR} -type f -iname "*.html" -exec vim -c "normal gg=G" -c "x" '{}' \;

html: indexes html_template html_files

html_template: ${CSS_FILE}
	./maketemplate.sh

html_files: makefile
	make -f Makefile2

indexes:
	./makeindex.sh

live:
	./node_modules/.bin/browser-sync start --server ${PUBLIC_DIR} --files ${PUBLIC_DIR}

makefile:
	./makemakefile.sh

serve:
	cd ${PUBLIC_DIR} && php -S localhost:8080

storage:
	ln -s $$(pwd)/${STORAGE_DIR} ${PUBLIC_DIR}/

watch: html
	find ${SRC_DIR} ${ASSETS_DIR} -type f | entr make html

.PHONY: build clean format html html_template indexes live watch
