# STA135 - FB Project
# R sctipt to pull from moetdb by net, calc, and throw away
# 20130313

library(MonetDB.R)
library(igraph)
"SELECT * FROM sys.fb WHERE no IN (" t ")" 

con = dbConnect(MonetDB.R(),"monetdb://localhost/fb",timeout = 99999)
dbListTables(con)

dbGetQuery(con, "SELECT * FROM fb WHERE no = 3")

net = 112
lin = as.integer(system(paste("./justgetnum.sh", net),intern=TRUE))
lines = paste(lin,collapse=",")
arg = sprintf("SELECT * FROM fb WHERE no IN (%s);",lines)
it = dbGetQuery(con, arg)		# WORKING?

makeedge = function(i) {
	fr = as.integer(strsplit(as.character(i[2])," ")[[1]][-1])
	cbind(i[1],fr)
}

# strip = apply(it[3:6,],1,makeedge)


out = data.frame(do.call("rbind",apply(it,1,makeedge)))
outt = graph.data.frame(out,directed = FALSE)
apl.noloner = average.path.length(outt,directed=F)#does NOT include friends with no connections.
apl.loner = average.path.length(outt,directed=F,unconnected=F)#friends that aren't connected are given the max. length
nedge = sum(degree(outt))#sum of number of edges incident to each node
nnode = length(V(outt))#number of nodes
nncluster = clusters(outt)$no	#clusters
trans = transitivity(outt, type="global")#prob. a user's friends are friends
diam = diameter(outt)#length of the longest connection in the graph
dens = graph.density(outt)#ratio of number of edges divided by number of possible edges


spit = 	function(i){
       	lin = as.integer(system(paste("./justgetnum.sh", i),intern=TRUE))
	lines = paste(lin,collapse=",")
	arg = sprintf("SELECT * FROM fb WHERE no IN (%s);",lines)
	it = dbGetQuery(con, arg)
	out = data.frame(do.call("rbind",apply(it,1,makeedge)))
	outt = graph.data.frame(out,directed = FALSE)
	apl.noloner = average.path.length(outt,directed=F)
	apl.loner = average.path.length(outt,directed=F,unconnected=F)
		nedge = sum(degree(outt))
	nnode = length(V(outt))		
	ncluster = clusters(outt)$no		
	trans = transitivity(outt, type="global")
	diam = diameter(outt)
	dens = graph.density(outt)
	c(apl.noloner,apl.loner,nnode,ncluster,trans,diam,dens)
}


net = c(112,234)
ret = data.frame(t(sapply(net, spit)))
row.names(ret) = net
names(ret) = c("apl.noloner","apl.loner","nnode","ncluster","trans","diam","dens")
ret

