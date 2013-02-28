#!/bin/sh

sort -u		# -n numeric


uniq		# neesd to be sorted as only looks at lines beside each other. -c adds counts.


sort fb_Strip | uniq -c 
