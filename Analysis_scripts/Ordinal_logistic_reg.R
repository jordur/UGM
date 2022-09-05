library(ggplot2)
library(MASS)
library(stringr)


wd <- "/home/ruben/ibv/resultados_estudios_asociacion/rePRS/ordinalreglog"
setwd(wd)

args <- commandArgs(trailingOnly = T)
seed <- args[1]
ordinalreglog <- function(vcf_df){
  for (i in seq_along(rownames(vcf_df))){
    line <- as.data.frame(t(vcf_df[i,]))
    line$pheno <- rownames(line)
    line$pheno <- lapply(line$pheno, strsplit, ".[0-9]+")
    line$pheno <- lapply(line$pheno, unlist)
    line$pheno <- factor(line$pheno, levels = c("Control", "MCI", "AD"), ordered = T)
    line[line == "./."] <- NA
    line[,1] <- factor(line[,1], levels = c("0/0", "0/1", "1/1"), ordered = T)
    colnames(line) <- c("geno", "pheno")
    
    model <- polr(formula = pheno ~ geno, data = line, Hess = T)
    pval <- pt(q = as.data.frame(summary(model)$coefficients)$'t value'[1], df = model$edf)
    
    if (i == 1){
      df_out <- data.frame(c(rownames(vcf_df)[i], model$coefficients[1], pval))
      df_out <- t(df_out)
    }
    else {
      line <- data.frame(c(rownames(vcf_df)[i], model$coefficients[1], pval))
      line <- t(line)
      df_out <- rbind(df_out,line)
    }
  }
  colnames(df_out) <- c("variant_id", "weight", "p-value")
  rownames(df_out) <- seq(nrow(df_out))
  df_out <- as.data.frame(df_out)
  df_out$weight <- as.numeric(df_out$weight)
  df_out$weight2 <- 10^(df_out$weight)
  return(list(df = df_out, model = model))
}


# bueno pues la cv ha sido una puta mierda así que simplemente voy a intentar hacer validaciones

vcf <-  read.delim("selected-variants-noheader.tsv", header = T, sep = "\t")
vcf2 <- vcf
set.seed(seed)
rownames(vcf) <- vcf$ID
vcf <- vcf[,-c(1:9)]
header <- read.delim("selected-variants.tsv", header = T, sep = "\t")
samples <- data.frame(colnames(header)[-c(1:9)], colnames(vcf))
vcf <- vcf[,sample(1:ncol(vcf)) ]




samplesize <- 0.85*ncol(vcf)


index = sample(seq_len(ncol(vcf)), size = samplesize)
vcf_val <- vcf[,index]
vcf_test <- vcf[,-index]
val_model <- ordinalreglog(vcf_val)
val_df <- val_model$df
val_df$ALT <- vcf2$ALT
write.table(val_df, file = "./prueba-validacion/validation_df2.tsv", col.names = T, row.names = F, quote = F, sep = "\t")

test_samples <- colnames(vcf_test)
test_samples <- subset(samples, samples$colnames.vcf. %in% test_samples)

write.table(test_samples, file = "./prueba-validacion/test_samples.tsv", col.names = T, row.names = F, quote = F, sep = "\t")
