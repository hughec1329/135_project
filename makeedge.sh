#!/bin/sh

# script to make our data into edgelist

cat $1 | awk -F " " '{for(i=3;i<=NF;i++) print $1,$i}' >> 'edge_'$1'.txt'
