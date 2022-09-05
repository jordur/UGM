#!/bin/bash
#SBATCH --job-name=filterVep
#SBATCH --partition=fast
#SBATCH --cpus-per-task 4 #"-c"
#SBATCH --mem 50G
#SBATCH --time=2:00:00
#SBATCH --mail-user=rubenncc96@gmail.com
#SBATCH --mail-type=ALL
#SBATCH -N 2
#SBATCH --output=./salidas/AFfilter_%A_%a.out
#SBATCH --error=./salidas/AFfilter_%A_%a.err

module load DBD-mysql/4.039-foss-2016b-Perl-5.24.0
module load VEP/104.3-foss-2016b-Perl-5.24.0

cd /home/jperez/pruebapipe/ruben/filtered/

## AD genes

filter_vep \
	-i variants_ADgenesconscan.vcf \
	-o variants_ADgenesconscan_AF1.vcf \
	--format vcf \
	--filter "gnomAD_NFE_AF < 0.01"

filter_vep \
        -i variants_ADgenesconscan.vcf \
        -o variants_ADgenesconscan_AF5.vcf \
        --format vcf \
        --filter "gnomAD_NFE_AF >= 0.05"


## all genes / consequences

filter_vep \
        -i variants_conscan.vcf \
        -o variants_conscan_AF1.vcf \
        --format vcf \
        --filter "gnomAD_NFE_AF < 0.01"

filter_vep \
        -i variants_conscan.vcf \
        -o variants_conscan_AF5.vcf \
        --format vcf \
        --filter "gnomAD_NFE_AF >= 0.05"

## secondary finding genes

filter_vep \
        -i variants_secgenesconscan.vcf \
        -o variants_secgenesconscan_AF1.vcf \
        --format vcf \
        --filter "gnomAD_NFE_AF < 0.01"

filter_vep \
        -i variants_secgenesconscan.vcf \
        -o variants_secgenesconscan_AF5.vcf \
        --format vcf \
        --filter "gnomAD_NFE_AF >= 0.05"

