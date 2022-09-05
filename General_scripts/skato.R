## Lectura de Z
#install.packages("SKAT",repos = "http://cran.us.r-project.org")
library(SKAT)
data<-read.delim("/home/jperez/pruebapipe/JordiD/results/pipeline/skato/recalibrated_variants_DP20_gatk_het_ALL_vep_af1_z_uniq.tsv",check.names=FALSE)
data[,2:86]->data2
t(data2)->Z

## Lectura de fenotipos
pheno<-read.delim("/home/jperez/pruebapipe/JordiD/results/pipeline/skato/AD.pheno", header=T)
phenovec<-as.numeric(pheno$y1)
phenovec[phenovec==1]<-6
phenovec[phenovec==3]<-1
phenovec[phenovec==2]<-1
phenovec[phenovec==6]<-0

# binary trait
obj<-SKAT_Null_Model(phenovec ~ 1, out_type="D")
SKAT(Z, obj, method="SKATO")$p.value
#SKAT(Z, obj, kernel = "linear.weighted", impute.method="bestguess")$p.value


