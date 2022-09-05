library(qqman)

id1 <- "AD-control"
id2 <- "AD-MCI"
id3 <- "MCI-control"
id4 <- "Disease"

wd <- "/home/ruben/ibv/resultados_estudios_asociacion/"
### Variantes raras
setwd(paste0(wd, "variantes_raras"))

general_raras <- "SKATO_rare.tsv"
data<-read.table(paste(id2,general_raras, sep = "_"), header=T)
obs<- data$P.value
data$chi<-qchisq(data$P.value,1,lower.tail=FALSE)
#lambda
median(data$chi,na.rm=TRUE)/qchisq(0.5,1)
qq(obs, main = paste0("Q-Q plot SKATO variantes raras ", id2))



### Variantes poco frecuentes
setwd(paste0(wd, "variantes_menos_frecuentes"))
data<-read.table(paste0("lessfreq_", id4, "_SKATO.tsv"), header=T)
obs<- data$P.value
data$chi<-qchisq(data$P.value,1,lower.tail=FALSE)
#lambda
median(data$chi,na.rm=TRUE)/qchisq(0.5,1)
qq(obs, main = paste0("Q-Q plot SKATO variantes poco frecuentes ", id4))


### Variantes comunes
setwd(paste0(wd, "variantes_comunes"))
data<-read.table(paste0("commonvars_allgenes_", id4, "_fisher_results.tsv"), header=T)
obs<- data$P
data$chi<-qchisq(data$P,1,lower.tail=FALSE)
#lambda
median(data$chi,na.rm=TRUE)/qchisq(0.5,1)
qq(obs, main = paste0("Q-Q plot SKATO variantes comunes ", id4))


