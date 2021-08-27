#!/bin/sh
source ./.env || exit 1

makefile=Makefile2

echo -e "# automatically generated makefile

all: all_files
" > $makefile

echo -n "all_files:" > $makefile.tmp

find ${SRC_DIR} -type f -iname '*.md' | sort |
while read sourcefile; do
  outfile=${sourcefile/${SRC_DIR}/${PUBLIC_DIR}}
  outfile=${outfile/\.md/.html}
  echo -n " $outfile" >> $makefile.tmp
  echo -e "${outfile}: ${sourcefile}
\t./makehtml.sh \$<
" >> $makefile    
done

cat $makefile.tmp >> $makefile
rm $makefile.tmp
echo -e "\n\n.PHONY: all all_files" >> $makefile
