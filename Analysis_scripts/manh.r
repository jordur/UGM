library(VennDiagram)
library(RColorBrewer)
library(wesanderson)
library(CMplot)

### COMUNES ###

setwd("~/ibv/resultados_estudios_asociacion")
file = "Merged_results_common_variants.tsv"
allassocs <- read.table(file, sep = "\t", header = T)
allassocs <- allassocs[,-8]
colnames(allassocs) <- c("SNP", "GENE", "CHR", "POS", "EA-Control", "EA-DCL", "DCL-Control")
pval <- 0.01

review <- subset(allassocs, (allassocs$`EA-Control` < pval | allassocs$`EA-DCL` < pval | allassocs$`DCL-Control` < pval)  )


#### COMMON
SNPs <- allassocs[(allassocs$`EA-Control` < pval & allassocs$`DCL-Control` < pval) & allassocs$`EA-DCL` > pval,1]
genes <- allassocs[(allassocs$`EA-Control` < pval & allassocs$`DCL-Control` < pval) & allassocs$`EA-DCL` > pval,2]


CMplot(allassocs[,c(-2)], plot.type="m",multracks = T ,LOG10=TRUE,col=c("grey30","grey60"),highlight=SNPs,
       highlight.col=c("green"),highlight.cex=1, highlight.text=genes,      
       highlight.text.col=c("#336600"),threshold=c(0.05,0.01),threshold.lty=2,   
       amplify=FALSE,file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)

#### DIFF
SNPs <- allassocs[(allassocs$`EA-Control` > pval & allassocs$`DCL-Control` > pval) & allassocs$`EA-DCL` < pval,1]
genes <- allassocs[(allassocs$`EA-Control` > pval & allassocs$`DCL-Control` > pval) & allassocs$`EA-DCL` < pval,2]


CMplot(allassocs[,c(-2)], plot.type="m",multracks = T ,LOG10=TRUE,col=c("grey30","grey60"),highlight=SNPs,
       highlight.col=c("green"),highlight.cex=1, highlight.text=genes,      
       highlight.text.col=c("#336600"),threshold=c(0.05,0.01),threshold.lty=2,   
       amplify=FALSE,file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)



## RARAS Y MENOS FRECUENTES ## 

setwd("~/ibv/resultados_estudios_asociacion")
file = "Merged_results_lessfreq_variants.tsv"
allassocs <- read.table(file, sep = "\t", header = T)
allassocs <- allassocs[,-c(4,8)]
colnames(allassocs) <- c("GENE", "CHR", "POS", "EA-Control", "EA-DCL", "DCL-Control")
pval <- 0.05

review <- subset(allassocs, (allassocs$`EA-Control` < pval | allassocs$`EA-DCL` < pval | allassocs$`DCL-Control` < pval)  )


#### COMMON
SNPs <- allassocs[(allassocs$`EA-Control` < pval & allassocs$`DCL-Control` < pval) & allassocs$`EA-DCL` > pval,1]
genes <- allassocs[(allassocs$`EA-Control` < pval & allassocs$`DCL-Control` < pval) & allassocs$`EA-DCL` > pval,1]


CMplot(allassocs, plot.type="m",multracks = T ,LOG10=TRUE,col=c("grey30","grey60"),highlight=SNPs,
       highlight.col=c("green"),highlight.cex=1, highlight.text=genes,      
       highlight.text.col=c("#336600"),threshold=c(0.05,0.01),threshold.lty=2,   
       amplify=FALSE,file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)

#### DIFF
SNPs <- allassocs[(allassocs$`EA-Control` > pval & allassocs$`DCL-Control` > pval) & allassocs$`EA-DCL` < pval,1]
genes <- allassocs[(allassocs$`EA-Control` > pval & allassocs$`DCL-Control` > pval) & allassocs$`EA-DCL` < pval,1]


CMplot(allassocs, plot.type="m",multracks = T ,LOG10=TRUE,col=c("grey30","grey60"),highlight=SNPs,
       highlight.col=c("green"),highlight.cex=1, highlight.text=genes,      
       highlight.text.col=c("#336600"),threshold=c(0.05,0.01),threshold.lty=2,   
       amplify=FALSE,file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,width=14,height=6)



# Comprobación asociaciones # 

fileAD = "/home/ruben/ibv/ADgenes.txt"
ADgenes = unlist(read.delim(fileAD))
setwd("~/ibv/resultados_estudios_asociacion")
file = "Merged_results_lessfreq_variants.tsv"
allassocs <- read.table(file, sep = "\t", header = T)
pval = 0.05
head(allassocs)
AD <- subset(allassocs, allassocs$GENE %in% ADgenes)
AD <- allassocs
sign <- subset(AD, (AD$EA-Control < pval | AD$EA-DCL < pval | AD$DCL-Control < pval))
sign
nrow(sign)
