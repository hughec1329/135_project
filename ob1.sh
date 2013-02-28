#!/bin/sh

# prepare sample - vectorise in R to boot?
head -n 10000 fb_mhrw.txt > fb_samp.txt	#will overwrite samp file each time
wc -l fb_samp.txt

cat fb_samp.txt | awk -F " " '{$2="";print}' | tr " " "\n" | sort | uniq -c > counts	# removes second column - number of times sampled.
# returns 'counts' file with n as first row
# then number times replicated and user id in second row.


sort -r counts > csort	# will sort with most at top.
