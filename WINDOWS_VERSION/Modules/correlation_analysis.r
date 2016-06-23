setwd("/Users/pra7mx/Desktop/LINCRSCAN_ANALYSIS")
file <- "correlation_file.txt"
a <- as.matrix(read.table(file,sep="\t",header=TRUE))
b <- a[69,]
age <- as.numeric(b[2:5])
corre <- c()
pvalue <- c()
name <- c()
for(i in 1:68)
{
 x <- a[i,]
 x1 <- as.numeric(x[2:5])
 k <- cor(x1,age,method="spearman")
 p <- cor.test(x1,age,method="spearman")$p.value
 n <- x[1]
 corre <- c(corre,k)
 pvalue <- c(pvalue,p)
 name <- c(name,n)
}
col <- cbind(name,corre,pvalue)
write.table(col,"correlation_result.txt",sep="\t",quote=FALSE,row.names=FALSE)
