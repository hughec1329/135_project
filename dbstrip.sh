#!/bin/bash

for i in /home/hugh/data/list/*
do
	lin=$(cat $i | tr "\n" "," | sed '$s/.$//') 
	mclient -d fb -s "COPY (SELECT * FROM sys.fb WHERE no IN ("$lin")) INTO '"$i"_strip';"
	echo "done" $i
done


