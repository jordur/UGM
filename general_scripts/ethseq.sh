#!/bin/sh
#SBATCH --job-name="EthSEQ"
#SBATCH --mem=200G
#SBATCH -n 4

module load R/4.0.2-foss-2016b-X11-20160819
module load BCFtools/1.3-foss-2016b


if [ ! -d "${outDir}/ethseq" ]; then
        mkdir "${outDir}/ethseq"
fi

bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t.\tGT[\t%GT]\n' ${outDir}/recalibrated_variants_DP20_gatk_het_ALL_vep.vcf > ${outDir}/ethseq/recalibrated_variants_DP20_gatk_het_ALL_vep_modified.vcf


Rscript ${scrDir}/ethseq.R
