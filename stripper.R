# STA135 - FB Project
# R sctipt to pull from moetdb by net, calc, and throw away
# 20130313

library(MonetDB.R)
library(RMonetDB)
"SELECT * FROM sys.fb WHERE no IN (" t ")" 

con = dbConnect(MonetDB.R(),"monetdb://localhost/fb",timeout = 99999)
dbListTables(con)

dbGetQuery(con, "SELECT * FROM fb WHERE no = 3")


net = 291
lin = as.integer(system(paste("./justgetnum.sh", net),intern=TRUE))
lines = paste(lin,collapse=",")
arg = sprintf("SELECT * FROM fb WHERE no IN (%s);",lines)
it = dbGetQuery(con, arg)		# WORKING?

net = c(112,234)
ret = list()

sapply(net, function(i){
	lin = as.integer(system(paste("./justgetnum.sh", i),intern=TRUE))
	lines = paste(lin,collapse=",")
	arg = sprintf("SELECT * FROM fb WHERE no IN (%s);",lines)
	dbGetQuery(con, arg)
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




