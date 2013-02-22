# STA 135 - fb network analyisis try
# 20130221 HCrockford

# install.packages(c("sna","network","statnet")) # FYI
library(statnet)
library(sna)
library(network)

fb = readLines("~/data/fb_samp.txt")
ff = strsplit(fb, " ")	# uid vs firend id? uids low, firned id > 950,000?
play = ff[1:10]
dup = 


# practice
t = list(c(1,2,3,4,5), c(4,5,6,7,8), c(1,2,3))
t[1] %in% t[2]		# cause not all t1 in t2
t[3] %in% t[1]		# nope?? wtf?
any(t[1] %in% t[2])	# how check if one firend in anothers firend list yet keep vecotirsed ??

match(t[1],t[3])
match(1:5,3:10)





# how best to represent firendships?i?
## edgelist seems too big / redundant
## sql w max num friends = ~ 5000 columns ? then index on what?
## list seems most logical - can grep over firends, or set a factor?

