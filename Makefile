PUBLIC=public
SRC=src
TEMPLATE_FILE=${SRC}/template.html
WEBSITE_NAME=My website
WEBSITE_AUTHOR=Jon

build: index
	for fname in ${SRC}/*.md; do \
		out=$$(basename $$fname); \
		out=$${out/.md/.html}; \
		out=${PUBLIC}/$$out; \
		pandoc --template ${TEMPLATE_FILE} --output $$out $$fname; \
	done; \
	rm ${SRC}/index.md

clean:
	-rm ${PUBLIC}/*.html

format:
	for f in ${PUBLIC}/*.html; do vim -c "normal gg=G" -c "x" $$f; done

index: ${SRC}/index.md

live:
	./node_modules/.bin/browser-sync start --server ${PUBLIC} --files ${PUBLIC}

prod: build format

watch:
	ls ${SRC}/* | entr make build

${SRC}/index.md:
	./makeindex.sh

.PHONY: build clean format index live prod watch
