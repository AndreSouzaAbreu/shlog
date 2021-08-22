#!/bin/sh
SRC_DIR=src
PUBLIC_DIR=public
TEMPLATE_FILE=./template.html

function get_outfile()
{
  srcfile=$1
  dir=$(dirname $srcfile)
  dir=${dir#${SRC_DIR}}
  destdir=${PUBLIC_DIR}$dir
  out=$(basename $srcfile)
  out=${out/.md/.html}
  out=$destdir/$out
  echo $out
}

function get_title()
{
  srcfile=$1
  title=$(grep '^title: ' $srcfile | head -n 1 | sed 's/title: //')
  if [[ -z $title ]]; then
    title=$(grep '^# ' $srcfile | head -n 1 | sed 's/# //')
  fi
  echo $title
}

function make_html()
{
  srcfile=$1
  outfile=$(get_outfile $srcfile)
  title=$(get_title $srcfile)
  destdir=$(dirname $outfile)

  mkdir -p $destdir
  pandoc --template ${TEMPLATE_FILE} --metadata title="$title" --output $outfile $srcfile
}

function make_html_all()
{
  find ${SRC_DIR} -type f -iname "*.md" |
    while read srcfile; do make_html $srcfile; done;
}

function main()
{
  if [[ -z $1 ]]; then
    make_html_all
  else
    while [[ -n $1 ]]; do
      make_html $1
      shift
    done
  fi
}

main $@
