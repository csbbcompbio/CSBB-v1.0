###START
###############################Hierarchical Clustering on ROW AND COLS BOTH##############################
##Color options are YellowGreenOrange , BlueWhiteRed , YellowBlackBlue, GreenWhitePurple
####Taking command line options
args = commandArgs(trailingOnly=TRUE)
path <- args[1]
filenameR <- args[2]	
####supress warnings
options(warn=-1) 
###check and install packages
print ("Checking and installing required packages")
if (!require("devtools")) install.packages("devtools",repos="http://cran.us.r-project.org")
devtools::install_github("rstudio/d3heatmap")
if (!require("gplots")) install.packages("gplots",repos="http://cran.us.r-project.org")
if (!require("R2HTML")) install.packages("R2HTML",repos="http://cran.us.r-project.org")
if (!require("RColorBrewer")) install.packages("RColorBrewer",repos="http://cran.us.r-project.org")
#####load Libraries
print ("Loading required libraries")
library(d3heatmap)
library(R2HTML)
library(htmlwidgets)
library(RColorBrewer)
library(gplots)
####setting path
setwd(path)
file <- filenameR
#### reading data
data <- as.matrix(read.table(file,sep="\t",header=TRUE,row.names=1))
print ("This is how input data looks like")
head(data)
####Based on user color preferences generating heatmap
print ("Based on User preference generating interactive and static heatmap")



####check user color
file <- strsplit(file,".txt")
outfile1 <- paste0(file, "_static", "_heatmap", ".pdf")
hmcols<-colorRampPalette(c("blue","white","red"))(256)
plot <- d3heatmap(data, scale = "row", color = scales::col_numeric(hmcols,c(0,1)), Rowv = TRUE, Colv=TRUE, show_grid=FALSE, theme="dark", anim_duration=0, brush_color="yellow", na.rm=TRUE, cellnote_scale=TRUE, cexRow = 0.5)
pdf(outfile1)
heatmap.2(data, scale = "row", col = hmcols, Rowv = TRUE, Colv=TRUE, show_grid=FALSE, na.rm = TRUE, cellnote_scale = TRUE, cexRow = 0.5, trace = "none", density.info = c("histogram","density","none"))
outfile <- paste0(file, "_interactive", "_heatmap", ".html")
saveWidget(plot, outfile)
dev.off()
####END