library(SKAT)
setwd("~/ibv/reskato")
wd <- paste0(getwd(),"/")
ref <- "/home/ruben/ibv/analisis/"
significativos <- "/home/ruben/ibv/reskato/significativos/"

File.Bed<-paste0(wd, "resktato_AD-control.bed")
File.Bim<-paste0(wd, "resktato_AD-control.bim")
File.Fam<-paste0(wd, "AD-control_SKAT.fam")
File.SetID<-paste0(wd, "SetID_all.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]


########################################ADgenes

File.Bed<-paste0(wd, "rarevars_ADgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_ADgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "AD.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars_AD.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_Disease_ADgenes.tsv"), sep="\t", row.names = F)
write.table(out$results, file="SkatO_results_Disease_ADgenes.tsv", sep="\t",row.names=F)

#################allgenes
File.Bed<-paste0(wd, "rarevars_allgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_allgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "AD.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_Disease_Allgenes.tsv"), sep="\t", row.names = F, quote = F)
write.table(out$results, file="SkatO_results_Disease_Allgenes.tsv", sep="\t",row.names=F, quote = F)

### AD-CONTROL (AD GENES)

File.Bed<-paste0(wd, "rarevars_ADgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_ADgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "AD-control_SKAT.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars_AD.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_AD-control_ADgenes.tsv"), sep="\t", row.names = F, quote = F)
write.table(out$results, file="SkatO_results_AD-control_ADgenes.tsv", sep="\t",row.names=F, quote = F)

### MCI-CONTROL (AD GENES)

File.Bed<-paste0(wd, "rarevars_ADgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_ADgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "MCI-control_SKAT.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars_AD.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_MCI-control_ADgenes.tsv"), sep="\t", row.names = F, quote = F)
write.table(out$results, file="SkatO_results_MCI-control_ADgenes.tsv", sep="\t",row.names=F, quote = F)


### AD-MCI (AD GENES)

File.Bed<-paste0(wd, "rarevars_ADgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_ADgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "AD-MCI_SKAT.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars_AD.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_AD-MCI_ADgenes.tsv"), sep="\t", row.names = F, quote = F)
write.table(out$results, file="SkatO_results_AD-MCI_ADgenes.tsv", sep="\t",row.names=F, quote = F)




### AD-CONTROL (ALL GENES)

File.Bed<-paste0(wd, "rarevars_allgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_allgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "AD-control_SKAT.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_AD-control_allgenes.tsv"), sep="\t", row.names = F, quote = F)
write.table(out$results, file="SkatO_results_AD-control_allgenes.tsv", sep="\t",row.names=F, quote = F)



### MCI-CONTROL (ALL GENES)

File.Bed<-paste0(wd, "rarevars_allgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_allgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "MCI-control_SKAT.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_MCI-control_allgenes.tsv"), sep="\t", row.names = F, quote = F)
write.table(out$results, file="SkatO_results_MCI-control_allgenes.tsv", sep="\t",row.names=F, quote = F)


### AD-MCI (ALL GENES)

File.Bed<-paste0(wd, "rarevars_allgenes_clean_pruned.bed")
File.Bim<-paste0(wd, "rarevars_allgenes_clean_pruned.bim")
File.Fam<-paste0(ref, "AD-MCI_SKAT.fam")
File.SetID<-paste0(wd, "SetID_2plusqualvars.tsv")
File.SSD <-paste0(wd, "prueba.SSD")
File.Info<-paste0(wd, "prueba.SSD.INFO")
Generate_SSD_SetID(File.Bed, File.Bim, File.Fam, File.SetID,File.SSD, File.Info)
FAM<-Read_Plink_FAM(File.Fam, Is.binary=T, flag1 = 1)
y<-FAM$Phenotype
SSD.INFO<-Open_SSD(File.SSD, File.Info)
# Number of samples
SSD.INFO$nSample
# Number of Sets
SSD.INFO$nSets
obj<-SKAT_Null_Model(y ~ 1, out_type="D")
out<-SKAT.SSD.All(SSD.INFO, obj, method = "SKATO", impute.method="bestguess")
out$results$P.adj = p.adjust(out$results$P.value, method = "fdr")
a <- out$results[which(out$results$P.value < (0.05)),]
write.table(a, file=paste0(significativos, "sign_AD-MCI_allgenes.tsv"), sep="\t", row.names = F, quote = F)
write.table(out$results, file="SkatO_results_AD-MCI_allgenes.tsv", sep="\t",row.names=F, quote = F)