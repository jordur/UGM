#!/bin/sh
#SBATCH --job-name="PlinkALL"
#SBATCH -c 4

if [ ! -d ${outDir}/plink ]; then
        mkdir -p ${outDir}/plink 
fi


# Plink recalibrated ALL files
plink --vcf ${outDir}/recalibrated_variants_DP20_gatk_het_ALL_vep_af1.vcf --make-bed --out ${outDir}/plink/recalibrated_ALL_af1
plink --vcf ${outDir}/recalibrated_variants_DP20_gatk_het_ALL_vep_af5.vcf --make-bed --out ${outDir}/plink/recalibrated_ALL_af5
plink --vcf ${outDir}/recalibrated_variants_DP20_gatk_het_ALL_vep_notAF.vcf --make-bed --out ${outDir}/plink/recalibrated_ALL_notAF
plink --vcf ${outDir}/recalibrated_variants_DP20_gatk_het_ALL_vep_AF15.vcf --make-bed --out ${outDir}/plink/recalibrated_ALL_AF15

# Plink ADgenes ALL files
plink --vcf ${outDir}/ADgenes_variants_DP20_gatk_het_ALL_vep_af1.vcf --make-bed --out ${outDir}/plink/ADgenes_ALL_af1
plink --vcf ${outDir}/ADgenes_variants_DP20_gatk_het_ALL_vep_af5.vcf --make-bed --out ${outDir}/plink/ADgenes_ALL_af5

# Filtering by missing genotypes
plink --bed ${outDir}/plink/recalibrated_ALL_af5.bed --bim ${outDir}/plink/recalibrated_ALL_af5.bim --fam ${refDir}/plink.fam --geno 0.25 --recode --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_af5_clean

plink --bed ${outDir}/plink/recalibrated_ALL_af1.bed --bim ${outDir}/plink/recalibrated_ALL_af1.bim --fam ${refDir}/plink.fam --geno 0.05 --recode --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_af1_clean

plink --bed ${outDir}/plink/recalibrated_ALL_notAF.bed --bim ${outDir}/plink/recalibrated_ALL_notAF.bim --fam ${refDir}/plink.fam --geno 0.05 --recode --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_notAF_clean

plink --bed ${outDir}/plink/recalibrated_ALL_AF15.bed --bim ${outDir}/plink/recalibrated_ALL_AF15.bim --fam ${refDir}/plink.fam --geno 0.25 --recode --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_AF15_clean

## Idem pero creando vcf per rvtest (puede que este paso se pueda implementar en la linea anterior)
plink --bed ${outDir}/plink/recalibrated_ALL_af5.bed --bim ${outDir}/plink/recalibrated_ALL_af5.bim --fam ${refDir}/plink.fam --geno 0.25 --recode vcf --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_af5_clean

plink --bed ${outDir}/plink/recalibrated_ALL_af1.bed --bim ${outDir}/plink/recalibrated_ALL_af1.bim --fam ${refDir}/plink.fam --geno 0.05 --recode vcf --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_af1_clean

plink --bed ${outDir}/plink/recalibrated_ALL_notAF.bed --bim ${outDir}/plink/recalibrated_ALL_notAF.bim --fam ${refDir}/plink.fam --geno 0.05 --recode vcf --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_notAF_clean

plink --bed ${outDir}/plink/recalibrated_ALL_AF15.bed --bim ${outDir}/plink/recalibrated_ALL_AF15.bim --fam ${refDir}/plink.fam --geno 0.25 --recode vcf --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/recalibrated_ALL_AF15_clean

#ADgenes
plink --bed ${outDir}/plink/ADgenes_ALL_af5.bed --bim ${outDir}/plink/ADgenes_ALL_af5.bim --fam ${refDir}/plink.fam --geno 0.25 --recode --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/ADgenes_ALL_af5_clean
plink --bed ${outDir}/plink/ADgenes_ALL_af1.bed --bim ${outDir}/plink/ADgenes_ALL_af1.bim --fam ${refDir}/plink.fam --geno 0.05 --recode --make-bed --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/ADgenes_ALL_af1_clean
plink --bed ${outDir}/plink/ADgenes_ALL_af5.bed --bim ${outDir}/plink/ADgenes_ALL_af5.bim --fam ${refDir}/plink.fam --geno 0.25 --recode vcf --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/ADgenes_ALL_af5_clean
plink --bed ${outDir}/plink/ADgenes_ALL_af1.bed --bim ${outDir}/plink/ADgenes_ALL_af1.bim --fam ${refDir}/plink.fam --geno 0.05 --recode vcf --hwe 0.00001 --set-missing-var-ids @:# --set-hh-missing --out ${outDir}/plink/ADgenes_ALL_af1_clean
