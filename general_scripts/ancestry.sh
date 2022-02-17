#!/bin/bash
#SBATCH --job-name=ancestry
#SBATCH --mem=100G

## Protocol:https://cran.r-project.org/web/packages/plinkQC/vignettes/AncestryCheck.pdf

module load PLINK/1.9b_6.24-x86_64

name='recalibrated_variants_ALL'
refname='all_phase3'
refDir='/home/jperez/ref/JordiD'

cd /home/jperez/COVID19/results/pipeline/plink/ancestry

## Format plink samples
plink --vcf ../../recalibrated_variants_DP20_gatk_het_ALL_vep_af1.vcf_mod --make-bed --out recalibrated_variants_ALL

awk 'BEGIN {OFS="\t"} ($5$6 == "GC" || $5$6 == "CG" || $5$6 == "AT" || $5$6 == "TA") {print $2}' ${name}.bim | sort | uniq > ${name}.ac_gt_snps

awk 'BEGIN {OFS="\t"} ($5$6 == "GC" || $5$6 == "CG" || $5$6 == "AT" || $5$6 == "TA") {print $2}' ${refDir}/${refname}.bim | sort | uniq > ${refname}.ac_gt_snps

## Removing A>T and C>G SNPs

plink   --bfile ${refDir}/${refname} \
	--exclude ${refname}.ac_gt_snps \
	--allow-extra-chr \
	--make-bed \
	--out  ${refname}.no_ac_gt_snps

plink   --bfile ${name} \
	--exclude ${name}.ac_gt_snps \
	--make-bed \
	--out ${name}.no_ac_gt_snps

## Prune

plink   --bfile ${name}.no_ac_gt_snps \
	--indep-pairwise 50 5 0.2 \
	--out ${name}.no_ac_gt_snps

plink   --bfile ${name}.no_ac_gt_snps \
	--extract ${name}.no_ac_gt_snps.prune.in \
	--make-bed \
	--out ${name}.pruned

## Filter ref by SNPs

plink   --bfile ${refname}.no_ac_gt_snps \
	--allow-extra-chr \
	--extract ${name}.no_ac_gt_snps.prune.in \
	--make-bed \
	--out ${refname}.pruned

## Check and correct chromosome mismatch

awk 'BEGIN {OFS="\t"} FNR==NR {a[$2]=$1; next} ($2 in a && a[$2] != $1) {print a[$2],$2}' ${name}.pruned.bim ${refname}.pruned.bim | sed -n '/^[XY]/!p' > ${refname}.toUpdateChr

plink 	--bfile ${refname}.pruned \
	--update-chr ${refname}.toUpdateChr 1 2 \
	--make-bed \
	--out ${refname}.updateChr

## Position missmatch

awk 'BEGIN {OFS="\t"} FNR==NR {a[$2]=$4; next} ($2 in a && a[$2] != $4) {print a[$2],$2}' ${name}.pruned.bim ${refname}.pruned.bim > ${refname}.toUpdatePos
	
## Allele flips

awk 'BEGIN {OFS="\t"} FNR==NR {a[$1$2$4]=$5$6; next} ($1$2$4 in a && a[$1$2$4] != $5$6 && a[$1$2$4] != $6$5) {print $2}' ${name}.pruned.bim ${refname}.pruned.bim > ${refname}.toFlip

## Upate positions and flip alleles

plink   --bfile  ${refname}.updateChr \
	--update-map ${refname}.toUpdatePos 1 2 \
	--flip ${refname}.toFlip \
	--make-bed \
	--out ${refname}.flipped

## Remove missmathes

awk 'BEGIN {OFS="\t"} FNR==NR {a[$1$2$4]=$5$6; next} ($1$2$4 in a && a[$1$2$4] != $5$6 && a[$1$2$4] != $6$5) {print $2}' ${name}.pruned.bim ${refname}.flipped.bim > ${refname}.mismatch

plink   --bfile  ${refname}.flipped \
	--exclude ${refname}.mismatch \
        --make-bed \
        --out ${refname}.clean
	

## Merge samples and refs

plink   --bfile  ${name}.pruned \
	--bmerge ${refname}.clean.bed ${refname}.clean.bim ${refname}.clean.fam \
	--make-bed \
	--out ${name}.merge.${refname}

## PCA

plink   --bfile ${name}.merge.${refname} \
	--pca \
	--make-bed  \
	--out ${name}.${refname}

