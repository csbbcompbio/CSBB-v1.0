options(warn=-1)
print ("Installing GEOquery")
source("https://bioconductor.org/biocLite.R")
biocLite("GEOquery")
print ("Loading Library GEOquery")
library(GEOquery)

######## Taking User Inputs
args = commandArgs(trailingOnly=TRUE)

path <- args[1]

GSEID <- args[2]

user_input <- args[3]

#####Setting Directory
setwd(path)

##### Citation Info
Cite <- as.matrix(citation("GEOquery"))
write.table(Cite,"Citation_Info.txt",quote=F,row.names=F)


##### If User needs to reterive the data of GSM id from GEO #####
if(identical(user_input,"GSM")){
gsm <- getGEO(GSEID)
Store_meta_data <- Meta(gsm)
outfile1 <- paste0(GSEID, "_Meta_data", ".txt")
write.table(Store_meta_data,outfile1,sep="\t",quote=F,row.names=F)
Table(gsm)[1:5,]
Store_gsm_values <- data.frame(Table(gsm))
Expression_values_Log2_transformed <- log2(as.numeric(Store_gsm_values$VALUE))
expression_matrix <- cbind(Store_gsm_values,Expression_values_Log2_transformed)
outfile2 <- paste0(GSEID, "_Expression_values", ".txt")
write.table(expression_matrix,outfile2,sep="\t",quote=F,row.names=F)}

##### If User needs to reterive the data of GDS id from GEO ######
if(identical(user_input,"GDS")){
gds <- getGEO(GSEID)
head(Meta(gds))
Store_meta_data <- as.matrix(Meta(gds))
outfile1 <- paste0(GSEID, "_Meta_data", ".txt")
write.table(Store_meta_data,outfile1,sep="\t",quote=F)
Store_sample_info <- Columns(gds)[,1:3]
outfile2 <- paste0(GSEID, "_Sample_Info", ".txt")
write.table(Store_sample_info,outfile2,sep="\t",quote=F,row.names=F)
eset <- GDS2eSet(gds,do.log2=TRUE)
expression_matrix <- as.matrix(exprs(eset))
final_expression_matrix <- cbind(featureNames(eset),expression_matrix)
outfile3 <- paste0(GSEID, "_Expression_data", ".txt")
write.table(final_expression_matrix,outfile3,sep="\t",quote=F,row.names=F)}

##### If User needs to reterive the data of GSE id from GEO
if(identical(user_input,"GSE")){
gse_new <- getGEO(GSEID,getGPL=FALSE)
gse <- getGEO(GSEID,GSEMatrix=FALSE)
head(Meta(gse))
Store_meta_data <- as.matrix(Meta(gse))
outfile1 <- paste0(GSEID, "_Meta_data", ".txt")
write.table(Store_meta_data,outfile1,sep="\t",quote=F)
Sample_names <- names(GSMList(gse))
Store_Pheno_data <- as.matrix(pData(phenoData(gse_new[[1]]))[1:length(Sample_names),c(1,6,8)])
All_phenodata <- cbind(Sample_names,Store_Pheno_data)
outfile2 <- paste0(GSEID, "_Pheno_data", ".txt")
write.table(All_phenodata,outfile2,quote=F,sep="\t",row.names=F)
gsmplatforms <- lapply(GSMList(gse),function(x) {Meta(x)$platform})
gsmlist=GSMList(gse)
Table(gsmlist[[1]])[1:length(gsmlist),]
probesets <- Table(GPLList(gse)[[1]])$ID
data.matrix <- do.call('cbind',lapply(gsmlist,function(x) {tab <- Table(x)
                                       mymatch <- match(probesets,tab$ID_REF)
                                       return(tab$VALUE[mymatch])
                                     }))
data.matrix <- apply(data.matrix,2,function(x) {as.numeric(as.character(x))})
data.matrix <- log2(data.matrix)
require(Biobase)
rownames(data.matrix) <- probesets
colnames(data.matrix) <- names(gsmlist)
pdata <- data.frame(samples=names(gsmlist))
rownames(pdata) <- names(gsmlist)
pheno <- as(pdata,"AnnotatedDataFrame")
eset <- new('ExpressionSet',exprs=data.matrix,phenoData=pheno)
expression_matrix <- as.matrix(exprs(eset))
final_expression_matrix <- cbind(featureNames(eset),expression_matrix)
outfile3 <- paste0(GSEID, "_Expression_data", ".txt")
write.table(final_expression_matrix,outfile3,sep="\t",quote=F,row.names=F)}