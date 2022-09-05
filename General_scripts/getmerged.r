library(VennDiagram)
library(RColorBrewer)
library(wesanderson)
library(CMplot)

### Common variants

setwd("~/ibv/analisis/fisherPlink/results")
general1 = "commonvars_allgenes_"
general2 = "_fisher_results.tsv"
ADMCI = "AD-MCI"
ADcontrol = "AD-control"
MCIcontrol = "MCI-control"
DiseaseName = "Disease"


ADMCItable <- read.table(paste0(general1,ADMCI, general2), header = TRUE, na.strings = "")
ADcontable <- read.table(paste0(general1,ADcontrol, general2), header = TRUE, na.strings = "")
MCIcontable <- read.table(paste0(general1,MCIcontrol, general2), header = TRUE, na.strings = "")
Disease <- read.table(paste0(general1,DiseaseName, general2), header = TRUE, na.strings = "")

ADMCItable <- ADMCItable[,-c(3:7,11)]
ADcontable <- ADcontable[,-c(3:7,11)]
MCIcontable <- MCIcontable[,-c(3:7,11)]
Disease <- Disease[,-c(3:7,11)]

names(ADMCItable)[3] <- "AD-MCI"
names(ADcontable)[3] <- "AD-control"
names(MCIcontable)[3] <- "MCI-control"
names(Disease)[3] <- "Disease"

allassocs <- merge(ADcontable, 
                merge(ADMCItable,
                      merge(MCIcontable,Disease,by = c("SNP", "GENE","CHR", "POS"), all = T),
                      by = c("SNP", "GENE","CHR", "POS"), all = T),
                by = c("SNP", "GENE","CHR", "POS"), all = T)
# allassocs <- merge(merged,MCIcontable, by = c("SNP", "GENE","CHR", "POS"), all = T)
# names(allassocs)[5] <- "AD-control"
# names(allassocs)[6] <- "AD-MCI"
# names(allassocs)[7] <- "MCI-control"

allassocs[is.na(allassocs)] = 1
allassocs <- unique(allassocs)
# 
# ADMCIvenn <- unlist(subset(ADMCItable, ADMCItable[8] < 0.05)[,1])
# ADcontvenn <- unlist(subset(ADcontable, ADcontable[8] < 0.05)[,1])
# MCIcontvenn <- unlist(subset(MCIcontable, MCIcontable[8] < 0.05)[,1])

setwd("~/ibv/resultados_estudios_asociacion/")
write.table(allassocs, "Merged_results_common_variants.tsv", sep = "\t", row.names = F, col.names = T, quote = F)


##### intentos de manhattan
allassocs_wogene <- allassocs[, -2]

pval <- 0.05

review <- subset(allassocs, (allassocs$`AD-control` < pval | allassocs$`AD-MCI` < pval | allassocs$`MCI-control` < pval)  )

associated <- subset(allassocs, ((allassocs$`AD-control` < pval & allassocs$`MCI-control` < pval)) & allassocs$`AD-MCI` > 0.05  )
not_associated <- subset(allassocs, (allassocs$`AD-MCI` < pval & (allassocs$`AD-control` > 0.05 & allassocs$`MCI-control` > 0.05))  )




CMplot(allassocs_wogene, plot.type="m",multracks=TRUE,threshold=c(0.05,0.01),threshold.lty=c(1,2), 
       threshold.lwd=c(1,1), threshold.col=c("black","grey"), amplify=TRUE,bin.size=1e6, col = c("#2A0BD9", "#FFE099", "#A60021"),
       chr.den.col=NULL, signal.col=c("red","green","blue"),
       signal.cex=1, file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,
       highlight.text.cex=1.4, highlight.col=NULL)
###################################


#### rare variants

setwd("~/ibv/resultados_estudios_asociacion/variantes_raras")

general = "_SKATO_rare.tsv"
ADMCI = "AD-MCI"
ADcontrol = "AD-control"
MCIcontrol = "MCI-control"
DiseaseName = "Disease"

ADMCItable <- read.table(paste0(ADMCI, general), header = TRUE, na.strings = "")[, -(3:5)]
ADcontable <- read.table(paste0(ADcontrol, general), header = TRUE, na.strings = "")[, -(3:5)]
MCIcontable <- read.table(paste0(MCIcontrol, general), header = TRUE, na.strings = "")[, -(3:5)]
Disease <- read.table(paste0(DiseaseName, general), header = TRUE, na.strings = "")[, -(3:5)]

names(ADcontable)[2] <- "AD-control"
names(ADMCItable)[2] <- "AD-MCI"
names(MCIcontable)[2] <- "MCI-control"
names(Disease)[2] <- "Disease"

# merged <- merge(ADcontable, ADMCItable, by = c("SetID"), all = T)
# allassocs <- merge(merged,MCIcontable, by = c("SetID"), all = T)

allassocs <- merge(ADcontable, 
                   merge(ADMCItable,
                         merge(MCIcontable,Disease,by = c("SetID"), all = T),
                         by = c("SetID"), all = T),
                   by = c("SetID"), all = T)

names(allassocs)[1] <- "GENE"
# names(allassocs)[2] <- "AD-control"
# names(allassocs)[3] <- "AD-MCI"
# names(allassocs)[4] <- "MCI-control"

to_ann_genes <- read.table("to_ann_skato.txt", sep = "\t", header = T)
colnames(to_ann_genes) <- c("CHR", "START", "END", "GENE")
valid_chr <- c(as.character(1:22), "X", "MT")
# to_ann_genes$CHR <- strtoi(to_ann_genes$CHR)
to_ann_genes <- subset(to_ann_genes, to_ann_genes$CHR %in% valid_chr)

allskatos_ann <- merge(to_ann_genes, allassocs, by = "GENE", all.y = T)

write.table(allskatos_ann, "Merged_results_rare_variants.tsv", sep = "\t", row.names = F, col.names = T, quote = F)

### less frequent variants

setwd("~/ibv/resultados_estudios_asociacion/variantes_menos_frecuentes")

general1 = "lessfreq_"
general2 = "_SKATO.tsv"
ADMCI = "AD-MCI"
ADcontrol = "AD-control"
MCIcontrol = "MCI-control"
DiseaseName = "Disease"


ADMCItable <- read.table(paste0(general1,ADMCI, general2), header = TRUE, na.strings = "")[, -(3:5)]
ADcontable <- read.table(paste0(general1,ADcontrol, general2), header = TRUE, na.strings = "")[, -(3:5)]
MCIcontable <- read.table(paste0(general1,MCIcontrol, general2), header = TRUE, na.strings = "")[, -(3:5)]
Disease <- read.table(paste0(general1,MCIcontrol, general2), header = TRUE, na.strings = "")[, -(3:5)]


names(ADcontable)[2] <- "AD-control"
names(ADMCItable)[2] <- "AD-MCI"
names(MCIcontable)[2] <- "MCI-control"
names(Disease)[2] <- "Disease"

# merged <- merge(ADcontable, ADMCItable, by = c("SetID"), all = T)
# allassocs <- merge(merged,MCIcontable, by = c("SetID"), all = T)

allassocs <- merge(ADcontable, 
                   merge(ADMCItable,
                         merge(MCIcontable,Disease,by = c("SetID"), all = T),
                         by = c("SetID"), all = T),
                   by = c("SetID"), all = T)

names(allassocs)[1] <- "GENE"
# names(allassocs)[2] <- "AD-control"
# names(allassocs)[3] <- "AD-MCI"
# names(allassocs)[4] <- "MCI-control"

to_ann_genes <- read.table("to_ann_skato.txt", sep = "\t", header = T)
colnames(to_ann_genes) <- c("CHR", "START", "END", "GENE")
valid_chr <- c(as.character(1:22), "X", "MT")
# to_ann_genes$CHR <- strtoi(to_ann_genes$CHR)
to_ann_genes <- subset(to_ann_genes, to_ann_genes$CHR %in% valid_chr)

allskatos_ann <- merge(to_ann_genes, allassocs, by = "GENE", all.y = T)

write.table(allskatos_ann, "Merged_results_lessfreq_variants.tsv", sep = "\t", row.names = F, col.names = T, quote = F)




