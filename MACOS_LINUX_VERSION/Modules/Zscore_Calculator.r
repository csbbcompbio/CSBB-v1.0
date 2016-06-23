args = commandArgs(trailingOnly=TRUE)
path <- args[1]
filenameR <- args[2]
setwd(path)
file <- filenameR
data <- as.matrix(read.table(file,sep="\t",header=T,row.names=1))
print ("This is how input file looks")
cat("\n")
head(data)
zscore_data <- c()
for(i in 1:nrow(data))
{
  mean_row <- mean(as.numeric(data[i,]),na.rm=TRUE)
  sd_row <- sd(as.numeric(data[i,]),na.rm=TRUE)
  zscore_row <- c()
  for(j in 1:ncol(data))
  {
   zscore_each <- ((data[i,j]-mean_row)/sd_row)
   zscore_row <-append(zscore_row,zscore_each)
  }
  zscore_data<-rbind(zscore_data,zscore_row)
  Sys.sleep(0.00005)
  cat(paste0("Zscore Calculations for Gene: ", i, " Completed", sep="\r"))
}
col <- cbind(row.names(data),zscore_data)
write.table(col,"temporaryfile.txt",sep="\t",row.names=F,quote=F)