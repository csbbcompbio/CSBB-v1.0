args = commandArgs(trailingOnly=TRUE)
path <- args[1]
filenameR <- args[2]
setwd(path)
file <- filenameR
data <- as.matrix(read.table(file,sep="\t",header=T,row.names=1))
print ("This is how input file looks")
cat("\n")
head(data)
new_data_col <-c()
for(i in 1:ncol(data))
{
 x <- as.numeric(data[,i])
 quantile_val <- quantile(x,0.75,na.rm=TRUE)
 y <- as.numeric(x/quantile_val)
 new_data_col <- cbind(new_data_col,y)
 Sys.sleep(0.05)
 cat(paste0("UpperQuantile for Sample: ", i, " Completed", sep="\r"))
}
col <- cbind(row.names(data),new_data_col)
write.table(col,"temporaryfile.txt",sep="\t",quote=F,row.names=F)