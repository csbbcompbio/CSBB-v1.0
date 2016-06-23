options(warn=-1)
####Taking command line options
args = commandArgs(trailingOnly=TRUE)

path <- args[1]

SRAid <- args[2]



##### Downloadind SRAdb
print ("Downloading SRAdb")
source('http://bioconductor.org/biocLite.R')
biocLite('SRAdb')
print ("Loading SRAdb Library")
library(SRAdb)
setwd(path)
####### Check if database is already downloaded before
print ("If SRAmetadb.sqlite Database is not already installed then estimated installing time is 10-15 mins. This is one time process")
if(!file.exists('SRAmetadb.sqlite')) srafile <<- getSRAdbFile()
srafile <- 'SRAmetadb.sqlite'

#########Setting working directory


con = dbConnect(RSQLite::SQLite(), srafile)
listSRAfile(SRAid, con)
a <- colDescriptions(sra_con=con)[1:5,]
b <- sraConvert( in_acc=SRAid, out_type=c('sample'), sra_con=con )
getSRAfile(in_acc=SRAid, sra_con = con, destDir = getwd(), fileType = 'sra',method='curl')