#!/bin/bash

# script to strip out peeps belonging to top nets.



nets=$(cat ~/data/topnets | awk -F " " '{print $2}' | head -n 100)
# top 100 nets

for t in $nets
do
	./getnet.sh ~/data/fb_mhrw.txt $t >> "/home/hugh/data/stripped/net_"$t".txt"
	echo "done " $t 
done
