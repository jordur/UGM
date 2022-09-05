#!/bin/bash
#SBATCH --job-name=gatkfilter
#SBATCH --partition=fast
#SBATCH --cpus-per-task 4 #"-c"
#SBATCH --mem 50G
#SBATCH --time=2:00:00
#SBATCH --output=./salidas/gatkfilterall_%A_%a.out
#SBATCH --error=./salidas/gatkfilterall_%A_%a.err

module load GATK/4.2.0.0-Java-1.8.0_92

echo $(date)

inDir="/home/jperez/pruebapipe/JordiD/results/pipeline"
refDir="/home/jperez/ref/JordiD"
outDir="/home/jperez/pruebapipe/ruben"

## Filter variants by Depth ##
gatk VariantFiltration \
        -R ${refDir}/Homo_sapiens_assembly38.fasta \
        -V ${inDir}/recalibrated_snps_raw_indels.vcf \
        -O ${outDir}/recalibrated_variants_DP20_gatk.vcf \
        -genotype-filter-name "Depth" -genotype-filter-expression "DP < 20" \
	--set-filtered-genotype-to-no-call true

## Getting control genotypes (at least 1 called && at least 1 VAR allele & BIALLELIC)
gatk SelectVariants \
	-R ${refDir}/Homo_sapiens_assembly38.fasta \
	-V ${outDir}/recalibrated_variants_DP20_gatk.vcf \
	-L ${refDir}/Exome_V6.bed \
	-O ${outDir}/recalibrated_variants_DP20_gatk_het_all.vcf \
	-select 'vc.getCalledChrCount() != 0 && vc.getHetCount() >= 1' \
	--restrict-alleles-to BIALLELIC \
	--exclude-filtered true
	
echo $(date)
