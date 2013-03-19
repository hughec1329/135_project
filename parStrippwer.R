# STA135 - FB Project
# R sctipt to pull from moetdb by net, calc, and throw away
# 20130313

# used on amazon ec2 - m3.2xlarge - 8core 30gb.

library(MonetDB.R)
library(igraph)
library(parallel)
con = dbConnect(MonetDB.R(),"monetdb://localhost/fb",timeout = 99999)

makeedge = function(i) {
	fr = as.integer(strsplit(as.character(i[2])," ")[[1]][-1])
	cbind(i[1],fr)
}

grab = 	function(i){
       	lin = as.integer(system(paste("./justgetnum.sh", i),intern=TRUE))
	lines = paste(lin,collapse=",")
	arg = sprintf("SELECT * FROM fbt WHERE id IN (%s);",lines)
	print(paste("done",i))
	it = dbGetQuery(con, arg)
}

strip = function(i){
	out = data.frame(do.call("rbind",apply(i,1,makeedge)))
	outt = graph.data.frame(out,directed = FALSE)
	apl.noloner = average.path.length(outt,directed=F)
	apl.loner = average.path.length(outt,directed=F,unconnected=F)
	nedge = sum(degree(outt))
	nnode = length(V(outt))		
	ncluster = clusters(outt)$no		
	trans = transitivity(outt, type="global")
	diam = diameter(outt)
	dens = graph.density(outt)
	c(apl.noloner,apl.loner,nedge,nnode,ncluster,trans,diam,dens)
}

stripspit = function(i){
	out = data.frame(do.call("rbind",apply(i,1,makeedge)))
	outt = graph.data.frame(out,directed = FALSE)
	npeeps = length(i[,1])
	apl.noloner = average.path.length(outt,directed=F)
	apl.loner = average.path.length(outt,directed=F,unconnected=F)
	nedge = sum(degree(outt))
	nnode = length(V(outt))		
	ncluster = clusters(outt)$no		
	trans = transitivity(outt, type="global")
	diam = diameter(outt)
	dens = graph.density(outt)
	res = c(npeeps,apl.noloner,apl.loner,nedge,nnode,ncluster,trans,diam,dens)
        system(paste('echo',paste(res,collapse=","),'>> results'))
        return(res)
}



matspit = function(i){
	out = data.frame(do.call("rbind",apply(i,1,makeedge)))
	outt = graph.data.frame(out,directed = FALSE)
	npeeps = length(i[,1])
	nedge = sum(degree(outt))
	nnode = length(V(outt))		
	res = c(nets[t],npeeps,nedge,nnode)
	t=t+1
        system(paste('echo',paste(res,collapse=","),'>> matcher'))
        return(res)
}




net = c(112,234)
ret = data.frame(t(sapply(net, spit)))
row.names(ret) = net
names(ret) = c("neeps","apl.noloner","apl.loner","nedge","nnode","ncluster","trans","diam","dens")




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

topnet[167:999,] # 833 nets from 500 to 46 members

tryy = topnet[990:999,]	# try

library(parallel)
detectCores()
cl = makeCluster(3,type="FORK")
clusterEvalQ(cl,Sys.getpid())
out = clusterApplyLB(cl,tryy[,2],spit)
out = clusterApplyLB(cl,tryy[,2],spit)
out = parSapply(cl,tryy[,2],spit)

stopCluster(cl)


row.names(ret) = net
names(ret) = c("neeps","apl.noloner","apl.loner","nedge","nnode","ncluster","trans","diam","dens")

### ACTUALLY USED
outt = lapply(nets, grab)
o = clusterApplyLB(cl,t(outt),function(i) stripspit(data.frame(i)))


