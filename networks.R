# STA 135 Project
# poke around netowrk relationships in fb dataset
# 20130120 HCrockford

props = read.delim("~/data/props.txt", sep = "#",header = FALSE)
names(props) = c("uid", "#samp", "totFR", "priv", "NID")
table(props$NID)
# some beloing to multiple networks.
popularNets = sort(table(props$NID), decreasing = TRUE ) 	# find popular nets.
head(popularNets)
strsplit(props$NID,"(?=[\\Q|\\E])",perl = TRUE)


