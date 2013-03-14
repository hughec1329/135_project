#!/bin/bash

# script to strip out peeps belonging to top nets.



nets=$(cat ./topnets | awk -F " " '{print $2}')
# top 100 nets

for t in $nets
do
	./getnet.sh /home/hugh/data/fb_mhrw.txt $t 
	echo "done " $t 
done
