#####ScatterPlot

setwd("/Users/pra7mx/Desktop/MARIANA_RNA-SEQ_MAPPED_9/Batch_Effect_Removal_Process/Scatter_Plots/Annotated_DE_RESULTS_atleast_3_4_or_2_4/")
file <- "Differential_expression_RUVG_Counts_FG_vs_HG_merging_bams_Annotated.txt"
data <- read.table(file,sep="\t",header=T,row.names=1)
head(data)
fc <- as.numeric(data[,1])
cpm <- as.numeric(data[,2])
enrichment <- data[,6]
library(ggplot2)
pdf("/Users/pra7mx/Desktop/MARIANA_RNA-SEQ_MAPPED_9/Batch_Effect_Removal_Process/Scatter_Plots/Scatter_Plot_R_Figures_revised/FG_DMSO_vs_HG_DMSO_merging_bams.pdf")
p <- ggplot(data, aes(cpm,fc))
Color_Legend <- factor(enrichment)
p +theme(axis.text = element_text(size = 14),axis.line = element_line(colour = "black"),axis.line.y = element_line(colour = "black"),legend.key = element_rect(fill = "white"),legend.background = element_rect(fill = "white"),legend.position = c(0.8, 0.9),panel.grid.major = element_line(),panel.grid.minor = element_blank(),panel.background = element_rect(fill = "white"))+geom_point(aes(colour = Color_Legend),shape = 1)+xlab("Average Log(Counts per Million)")+ylab("Log(Fold Change)")+ggtitle("FG DMSO vs HG DMSO")+ geom_hline(aes(yintercept=-1))+geom_hline(aes(yintercept=1))+scale_colour_manual(values = c("FG_Enriched" = "darkorange","HG_Enriched" = "darkgreen","FG=HG" = "lightgrey","Not FG or HG"="black"))
dev.off()