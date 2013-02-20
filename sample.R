# STA135 - FB data
# code to sample large file
# 20130206 HCrockford

sampFB = function(file, num){
	nlines = system(paste("wc -l",file), intern = TRUE)
	numlines = as.integer(strsplit(nlines," ")[[1]][1])
	samplines = sample(1:numlines, round(num/10))
	sapply(samplines,function(i) {scan(file=file, what = character(),n=10,skip=i)})
}

fbfile = "~/data/fb_mhrw.txt"

sampFB(fbfile, 100)


