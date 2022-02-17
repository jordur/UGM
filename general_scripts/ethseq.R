##Requirements
#if (!require("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#
#BiocManager::install("SNPRelate")
#BiocManager::install("gdsfmt")
#install.packages("EthSEQ", repos = "https://cloud.r-project.org/")

##EthSEQ
library(EthSEQ)
setwd("/home/jperez/COVID19/results/pipeline/ethseq")

## Construir reference model
#ethseq.RM(vcf.fn, annotations, out.dir = "./",
#          model.name = "Reference.Model", bed.fn = NA, call.rate = 1, cores = 1)

## Executar amb Exonic.all com a referència
ethseq.Analysis(
            target.vcf = "recalibrated_variants_DP20_gatk_het_ALL_vep_modified.vcf",
            model.available = "Exonic.All",
            verbose=TRUE,
            out.dir="/home/jperez/COVID19/results/pipeline/ethseq",
            composite.model.call.rate = 0.99,
            space = "3D", 
            cores = 4)

