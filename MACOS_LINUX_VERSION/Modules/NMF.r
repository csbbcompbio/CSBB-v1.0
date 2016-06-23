#######START

####supress warnings
options(warn=-1)

##CHECKING AND INSTALLING NMF MODULE###
print ("Checking and Installing NMF package in R")
if (!require("devtools")) install.packages("devtools",repos="http://cran.us.r-project.org")
if (!require("NMF")) install.packages("NMF", repos="http://cran.us.r-project.org")
if (!require("fastICA")) install.packages("fastICA", repos="http://cran.us.r-project.org")

######LOADING NMF LIBRARY########
print ("Loading NMF library")
rm(list=ls(all=TRUE))
library(NMF)
library(fastICA)

####Taking command line options
args = commandArgs(trailingOnly=TRUE)

path <- args[1]

filenameR <- args[2]

####SETTING THE DIRECTORY######
setwd(path)

file <- filenameR

#READING USER INPUT DATA
print ("Reading input data")
data = as.matrix(read.table(file, sep="\t", header=TRUE, row.names=1))
print ("This is how input data looks")
head(data)

#Convert to data frame 
print ("Converting input data into data frame")
data2<-as.data.frame(data)



#Add dummy values to NA 
data2[is.na(data2)] <- 123456789
#Use weights to balance out NA values
w<-as.matrix(data2)
w[w==123456789] <- 0
w[w!=0]<-1
number <- as.numeric(ncol(w))
valueuse <- as.integer(number*0.9)
#Estimate value of R
print ("Performing Nonnegative Matrix Factorization using ls-nmf")
estim.r <- nmf(data2, valueuse, 'ls-nmf', nrun = 100, seed = "ica", weight=w)
print ("Generating Consensus Heatmap")
#A heatmap to see consensus of 10 runs
outfile <- paste0(file, "_NMF", "_CONSENSUSMAP", ".pdf")
pdf(outfile)
consensusmap(estim.r, color = "-RdYlBu", distfun = function(x) as.dist(1 - x), hclustfun = "complete", Rowv = TRUE, Colv = TRUE, info = FALSE,labCol=colnames(estim.r),labRow=colnames(estim.r))
dev.off()