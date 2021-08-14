#!/bin/sh

SRC=src
INDEX=${SRC}/index.md
WEBSITE_NAME="My website"

function getPreamble() {
cat << EOF
---
title: ${WEBSITE_NAME}
---

# ${WEBSITE_NAME}

EOF
}

function getUrls() {
  for fname in ${SRC}/*.md; do
    [[ "$fname" == "$INDEX" ]] && continue;
    title=$(grep '^title: ' $fname | sed 's/title: //');
    uri=./$(basename $fname);
    uri=${uri/.md/.html};
    echo "- [$title]($uri)";
  done
}

(getPreamble && getUrls) > ${INDEX}
