# STA 135 - SNA HW
# measure connectedness using shell tools
fil = "~/data/fb_mhrw.txt"
len = as.integer(strsplit(system(sprintf("wc -l %s",fil),intern=TRUE)," ")[[1]][1])
len = 957359	# length of file.
n=1000
size = floor(len/n)
cuts = seq(1,len,n)

fboot = function(size){
	for(i in 1:length(cuts)-1){	# is there a way to vectorise this?
		ran = paste(paste(cuts[i],cuts[i+1],sep=","),"p",sep = "")
		# com = sprintf("sed -n %s %s | awk -F ' ' '{$2='';print}' | tr ' ' '\n' | sort | uniq -c " , ran,fil)	# sprint will throw escape infront of double quote, while awk trips on single quote? split up or put as fn, send as argument.
		com = paste("./getcon.sh",ran,fil)
		t = system(com,intern=TRUE)	# do actually need all this data or just count of uniq vs duplicates?
	}
}

