# MPM406 - SNA try
# 20130213 - HCrockford

# karate example from here : http://igraph.sourceforge.net/screenshots2.html#8
library(igraph)
karate = read.graph("karate.net", format = "pajek")
karate = read.graph("karate.net", format = "edgelist")
tkplot(karate)

wt = walktrap.community(karate, modularity=TRUE)
dend = as.dendrogram(wt, use.modularity=TRUE)
plot(dend)

# using FB edgelist found online somewhere?
## - NOT our fb data as I thought

# fb = read.graph("1912.edges",format = "edgelist")
# fb = read.graph("short.edges",format = "edgelist")
fb = read.graph("shortt.edges",format = "edgelist")
tkplot(fb)
fbb = walktrap.community(fb, modularity=TRUE)
dend = as.dendrogram(fbb, use.modularity=TRUE)


