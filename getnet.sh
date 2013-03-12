#!/bin/bash
# code to pull peeps that are member of certain network

# $1 - filename
# $2 - network to search for

lnumber=$(cat ~/data/mhrw-nodeproperties-anonymized.txt | cut -d "#" -f 5 | tr "|" " " | grep -nr "^"$2 | cut -d ":" -f 1)	# find line numbers of net match. ( could do simple grep but will get user ids with net name included.)

for i in $lnumber
do
	# awk 'NR=='$i'{print $0}' $1 >> 'net_'$2.txt	# return that line
	 # head -n $i $1 | tail -n 1 # >> 'net_'$2.txt	# much faster
	 sed $i'q;d' $1 >> 'net_'$2.txt
done

	
