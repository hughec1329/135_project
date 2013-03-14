#!/bin/sh

cat ~/data/mhrw-nodeproperties-anonymized.txt | cut -d "#" -f 5 | awk -F "|" '{for(i=1;i<=NF;i++) if ($i =='$1') print NR}'

