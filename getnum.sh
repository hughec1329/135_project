#!/bin/sh

nets=$(cat ./topnets | awk -F " " '{print $2}' | head -n 100)

for i in $nets
do
	cat ~/data/mhrw-nodeproperties-anonymized.txt | cut -d "#" -f 5 | awk -F "|" '{for(i=1;i<=NF;i++) if ($i =='$i') print NR}' >> '/home/hugh/data/list/l_'$i
	echo $i
done


