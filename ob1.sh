#!/bin/sh

sort -u		# -n numeric


uniq		# neesd to be sorted as only looks at lines beside each other. -c adds counts.


sort fb_Strip | uniq -c 

echo "2,3,4,5,5,6,7,2" | tr "," "\n" | sort | uniq -c > counts	# DONE

cat fb_samp | tr "," "\n" | sort | uniq -c > counts	# DONE

cat fb_samp.txt | awk -F " " '{$2="";print}' | tr " " "\n" | sort | uniq -c > counts	# removes second column - number of times sampled.
# returns 'counts' file with n as first row
# then number times replicated and user id in second row.

sort -r counts > csort	# will sort with most at top.

head -n 10000 fb_mhrw.txt > fb_samp.txt	#will overwrite samp file each time
wc -l fb_samp.txt
