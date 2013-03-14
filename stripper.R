# STA135 - FB Project
# R sctipt to pull from moetdb by net, calc, and throw away
# 20130313

library(MonetDB.R)
library(RMonetDB)
"SELECT * FROM sys.fb WHERE no IN (" t ")" 

con = dbConnect(MonetDB.R(),"monetdb://localhost/fb")
dbListTables(con)

dbGetQuery(con, "SELECT * FROM fb WHERE no = 3")


