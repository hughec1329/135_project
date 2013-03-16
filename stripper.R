# STA135 - FB Project
# R sctipt to pull from moetdb by net, calc, and throw away
# 20130313

library(MonetDB.R)
library(igraph)
con = dbConnect(MonetDB.R(),"monetdb://localhost/fb",timeout = 99999)

makeedge = function(i) {
	fr = as.integer(strsplit(as.character(i[2])," ")[[1]][-1])
	cbind(i[1],fr)
}

spit = 	function(i){
       	lin = as.integer(system(paste("./justgetnum.sh", i),intern=TRUE))
	lines = paste(lin,collapse=",")
	arg = sprintf("SELECT * FROM fb WHERE no IN (%s);",lines)
	it = dbGetQuery(con, arg)
	out = data.frame(do.call("rbind",apply(it,1,makeedge)))
	outt = graph.data.frame(out,directed = FALSE)
	npeeps = length(it[,1])
	apl.noloner = average.path.length(outt,directed=F)
	apl.loner = average.path.length(outt,directed=F,unconnected=F)
	nedge = sum(degree(outt))
	nnode = length(V(outt))		
	ncluster = clusters(outt)$no		
	trans = transitivity(outt, type="global")
	diam = diameter(outt)
	dens = graph.density(outt)
	c(npeeps,apl.noloner,apl.loner,nedge,nnode,ncluster,trans,diam,dens)
}


grab = function(i){
	ret = data.frame(t(sapply(i, spit)))
	row.names(ret) = i
	names(ret) = c("neeps","apl.noloner","apl.loner","nedge","nnode","ncluster","trans","diam","dens")
	return(ret)
}


net = c(112,234)
fbak = grab(net)	# working


## finding nets we want to sample

topnet = read.table("topnets")
hist(topnet[,1])
plot(topnet[,1])
range(unique(topnet[,1]))
head(topnet)
topnet[150:180,]
topnet[topnet[,1] %in% seq(500,50,-50),]
int = c(1,2,4,5,6,9,13,15,18,23,30,35,48,69,93,118,167,208,239,273,309,376,471,609,959)	
ournet = topnet[int,2]	# 25 nets spread throughout size range.

fbak = grab(ournet)


