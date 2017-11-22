#!/bin/bash

# add_prons_for_acronyms.sh
# Copyright 2017   Kyu Jeong Han (queue.han@gmail.com)
#

if [ $# != 3 ]; then
  echo "Usage: $0 [options] <letter-dict> <acronym-list> <out-lexicon>"
  echo ""
  echo "main options (for others, see top of this script file)"
  exit 1;
fi

dict=$1
oov=$2
outlex=$3
dir=`mktemp -d`
rm -r $outlex

for list in `cat $oov`; do
  echo $list
  rm -r $dir/prons
  for letter in `echo $list | sed "s/[_\.]/\n/g" | awk NF`; do
    grep "^$letter " $dict | cut -d' ' -f2- >> $dir/prons
  done
  pron_seq=`cat $dir/prons | tr '\n' ' ' | sed 's/$/\n/g'`
  echo "$list $pron_seq" >> $outlex
done

rm -r $dir

