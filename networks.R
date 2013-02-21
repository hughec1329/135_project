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
plot(head(popularNets,n=100))
sum(popularNets[1:100])	# first 100 most popular nets acocunt for 230k peeps.
sum(popularNets[1:20])	# first 20 most popular nets acocunt for 110k peeps.
sum(popularNets[1:20])/sum(popularNets)		# top 20 nets cover 20% of popn


max(sapply(strsplit(as.character(props$NID),"|",fixed = TRUE),length))	# get amx number of nets anyone belongs to. = 5

# how to structure - in list? 
## need to be able to sort by network - match on all 5 dimensions?
## how test if my second net is same as evans first?

try = lapply(props, function(i) c(i[-5],strsplit(as.character(i[5]),"|",fixed = TRUE)))


u = data.frame(id = c(1,2,3,4,5), NID = c("23","23|2343","3434","342","343|344"))
o = apply(u,1,function(i) c(i[1],strsplit(as.character(i[2]),"|",fixed = TRUE)))



