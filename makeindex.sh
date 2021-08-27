#!/bin/sh
source ./.env || exit 1

function capitalize() {
  echo $@ | sed 's/[a-z]/\U&/'
}

function uppercase() {
  echo $@ | sed 's/[a-z]/\U&/g'
}

function getUrlsFromDir() {
  dir=$1
  index=$dir/index.md

  subdirs=$(find $dir -maxdepth 1 -type d | wc -l)
  (( $subdirs > 1 )) && echo -e "${TITLE_OF_LIST_OF_DIRS}\n"

  find $dir -maxdepth 1 -type d | sort |
  while read otherdir; do
    [[ "$dir" == "$otherdir" ]] && continue
    nfiles=$(ls $otherdir | wc -l)
    (( $nfiles == 0 )) && continue;
    title=$(basename $otherdir)
    title=$(capitalize $title)
    uri=${otherdir#${SRC_DIR}}/
    echo "- [$title]($uri)"
  done

  (( $subdirs > 1 )) && echo;
  files=$(ls $dir/*.md | wc -l)
  (( $files > 1 )) && echo -e "${TITLE_OF_LIST_OF_FILES}\n"

  find $dir -maxdepth 1 -type f -iname "*.md"| sort |
  while read filepath; do
    [[ "$filepath" == "$index" ]] && continue
    title=$(grep '^title: ' $filepath | head -n 1 | sed 's/title: //')
    if [[ -z $title ]]; then
      title=$(grep '^# ' $filepath | head -n 1 | sed 's/# //')
    fi
    dir=$(dirname $filepath)
    dir=${dir#${SRC_DIR}}
    filename=$(basename $filepath)
    filename=${filename/.md/.html}
    uri=${dir}/${filename}
    echo "- [$title]($uri)"
  done
}

function makeIndexes() {
  find ${SRC_DIR} -type d | while read dir; do
    nfiles=$(ls $dir | wc -l)
    (( $nfiles == 0 )) && continue;
    title="${WEBSITE_NAME}"
    dir_rel=${dir#${SRC_DIR}}
    if [[ -n $dir_rel ]]; then
      title=$(basename $dir_rel)
      title=$(uppercase $title | sed 's;/;;')
    fi
    index=$dir/index.md
    (echo -ne "# $title\n\n" && getUrlsFromDir $dir) > $index
  done
}

makeIndexes
