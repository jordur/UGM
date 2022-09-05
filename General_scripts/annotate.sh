#!/bin/bash
#SBATCH --job-name=VEP_annotation
#SBATCH --partition=fast
#SBATCH --cpus-per-task 4 #"-c"
#SBATCH --mem 50G
#SBATCH --time=4:00:00
#SBATCH -N 2
#SBATCH --output=./salidas/veprecall_%A_%a.out
#SBATCH --error=./salidas/veprecall_%A_%a.err

module load VEP/104.3-foss-2016b-Perl-5.24.0
module load DBD-mysql/4.039-foss-2016b-Perl-5.24.0

refDir=/home/jperez/ref/JordiD
outDir=/home/jperez/pruebapipe/ruben
## VEP ##
vep \
    --cache \
    --dir  ${refDir}\
    --dir_cache ${refDir} \
    --sift b \
    --fork 4 \
    --variant_class \
    --polyphen b \
    --canonical \
    --humdiv \
    --gene_phenotype \
    --regulatory \
    --numbers \
    --total_length \
    --vcf \
    --vcf_info_field CSQ \
    --symbol \
    --uniprot \
    --check_existing \
    --clin_sig_allele 1 \
    --af_1kg \
    --af_esp \
    --af_gnomad \
    -i ${outDir}/recalibrated_variants_DP20_gatk_het_all.vcf \
    --plugin CADD,/home/jperez/.vep/whole_genome_SNVs.tsv.gz \
    -o ${outDir}/recalibrated_variants_DP20_gatk_het_all_vep.vcf

echo $(date)
