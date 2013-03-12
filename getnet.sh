#!/bin/bash
# code to pull peeps that are member of certain network

# $1 - filename
# $2 - network to search for

lnum=cat $1 | cut -d "#" -f 5 | grep -nr $2 | cut -d ":" -f 1	# find line numbers of net match. ( could do simple grep but will get user ids with net name included.)
sed -n $lnum"p" $1	# return that line
