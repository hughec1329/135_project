STA 135 Project - Facebook network mapping.
=====
## file descriptions

* topnet - list of netowrks sorted by number of members - input for stripnet (cmd to create in header)
* getnet - pulls members of network from large file into net_#.txt by matching network id in properties file and extracting from mrw file.
** $1 - file to extract from, $2 - network looking for. properties file harcoded
* stripnet - loop over top 100 networks in topet and run getnet - will take a while to run, wait until night to run.
* makeedge - convert our data form to edgelist form for analysis in R. V fast. 

