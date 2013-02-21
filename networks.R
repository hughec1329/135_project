# STA 135 Project
# poke around netowrk relationships in fb dataset
# 20130120 HCrockford

props = read.delim("~/data/props.txt", sep = "#",header = FALSE)
names(props) = c("uid", "#samp", "totFR", "priv", "NID")
table(props$NID)
# some beloing to multiple networks.
popularNets = sort(table(props$NID), decreasing = TRUE ) 	# find popular nets. most popular is No network (~450k)
popularNets = popularNets[-1]	# cull no nets
head(popularNets,n=100)	
sum(popularNets[1:100])	# first 100 most popular nets acocunt for 230k peeps.


max(sapply(strsplit(as.character(props$NID),"|",fixed = TRUE),length))	# get amx number of nets anyone belongs to. = 5

# how to structure - in list? 
## need to be able to sort by network - match on all 5 dimensions?
## how test if my second net is same as evans first?




