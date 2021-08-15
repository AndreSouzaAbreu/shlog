PUBLIC=public
SRC=src

build: html format

clean:
	find ${PUBLIC} -type f -iname "*.html" -delete
	find ${PUBLIC} -type d

format:
	find ${PUBLIC} -type f -iname "*.html" -exec vim -c "normal gg=G" -c "x" '{}' \;

html: indexes
	./makehtml.sh

indexes:
	./makeindex.sh

live:
	./node_modules/.bin/browser-sync start --server ${PUBLIC} --files ${PUBLIC}

watch:
	find ${SRC} -type f | entr make html

.PHONY: build clean format html indexes live watch
