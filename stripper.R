# STA135 - FB Project
# R sctipt to pull from moetdb by net, calc, and throw away
# 20130313

library(MonetDB.R)
library(igraph)
"SELECT * FROM sys.fb WHERE no IN (" t ")" 

con = dbConnect(MonetDB.R(),"monetdb://localhost/fb",timeout = 99999)
dbListTables(con)

dbGetQuery(con, "SELECT * FROM fb WHERE no = 3")

net = 69
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

average.path.length(g,directed=F)#does NOT include friends with no connections.
average.path.length(g,directed=F,unconnected=F)#friends that aren't connected are given the max. length
sum(degree(g))#sum of number of edges incident to each node
length(V(g))#number of nodes
clusters(g)#clusters
transitivity(g, type="global")#prob. a user's friends are friends
diameter(g)#length of the longest connection in the graph
graph.density(g)#ratio of number of edges divided by number of possible edges


net = c(112,234)

ret = sapply(net, function(i){
       	lin = as.integer(system(paste("./justgetnum.sh", i),intern=TRUE))
	lines = paste(lin,collapse=",")
	arg = sprintf("SELECT * FROM fb WHERE no IN (%s);",lines)
	matrix(unlist(dbGetQuery(con, arg)),,2)
})



dbGetQuery(con, "SELECT * FROM fb WHERE no IN (32,424,6454);")	# works fine
fin = dbSendQuery(con, arg)
fetch(fin)	# cant fetch monet?

monet.frame(con, arg)

# works when I write to file then read in?? 
write(arg,"arg.txt")
system("mclient -d fb < arg.txt", intern = TRUE)

nom = system(paste("./dbget.sh", net),intern = TRUE)
system(paste("mclient -d fb < ",nom) , intern = TRUE)
