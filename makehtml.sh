#!/bin/sh
SRC_DIR=src
PUBLIC_DIR=public
TEMPLATE_FILE=./assets/template.html

# find ${SRC_DIR} -type f -iname "*.md" | while read f; do echo f is $f; done
find ${SRC_DIR} -type f -iname "*.md" |
while read filepath; do
  dir=$(dirname $filepath)
  dir=${dir#${SRC_DIR}}
  destdir=${PUBLIC_DIR}$dir
  out=$(basename $filepath)
  out=${out/.md/.html}
  out=$destdir/$out

  title=$(grep '^title: ' $filepath | head -n 1 | sed 's/title: //')
  if [[ -z $title ]]; then
    title=$(grep '^# ' $filepath | head -n 1 | sed 's/# //')
  fi

  mkdir -p $destdir
  pandoc --template ${TEMPLATE_FILE} --metadata title="$title" --output $out $filepath
done;
