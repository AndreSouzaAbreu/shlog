#!/bin/sh
PUBLIC_DIR=public
SRC_DIR=src
makefile=Makefile2
cssfile=assets/app.css
all=''

echo -e "# automatically generated makefile

all_files: all
" > $makefile

echo -n "all:" > $makefile.tmp

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
