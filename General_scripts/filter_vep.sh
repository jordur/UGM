#!/bin/bash
#SBATCH --job-name=filterVep
#SBATCH --partition=fast
#SBATCH --cpus-per-task 4 #"-c"
#SBATCH --mem 50G
#SBATCH --time=2:00:00
#SBATCH --mail-user=rubenncc96@gmail.com
#SBATCH --mail-type=ALL
#SBATCH -N 2
#SBATCH --output=./salidas/filter_%A_%a.out
#SBATCH --error=./salidas/filter_%A_%a.err

module load DBD-mysql/4.039-foss-2016b-Perl-5.24.0
module load VEP/104.3-foss-2016b-Perl-5.24.0

cd /home/jperez/pruebapipe/ruben/

filter_vep \
	-i variants_vep.vcf \
	-o  ./filtered/variants_conscan.vcf \
	--format vcf \
	--filter "Consequence in /home/jperez/ref/consequences.txt" \
	--filter "CANONICAL is YES" \
	--only_matched
