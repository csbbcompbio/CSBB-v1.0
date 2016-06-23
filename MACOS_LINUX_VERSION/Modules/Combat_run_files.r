setwd("/data/zorn_lab_praneet/Mariana/COMBAT/")
source('/data/zorn_lab_praneet/Mariana/COMBAT/ComBat.R')
ComBat('RSEM_AVERAGE_TPM_SAMPLES_WO_DKK_and_Batch3_only_expressed_genes.csv','Batch_File.txt',skip=1,par.prior=F)