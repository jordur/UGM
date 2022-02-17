#!/bin/bash
#SBATCH --job-name=filterVep
#SBATCH --partition=fast
#SBATCH --cpus-per-task 4 #"-c"
#SBATCH --mem 50G
#SBATCH --time=2:00:00
#SBATCH --mail-user=rubenncc96@gmail.com
#SBATCH --mail-type=ALL
#SBATCH -N 2
#SBATCH --output=filter_%A_%a.out
#SBATCH --error=filter_%A_%a.err

module load DBD-mysql/4.039-foss-2016b-Perl-5.24.0
module load VEP/104.3-foss-2016b-Perl-5.24.0

cd /home/jperez/pruebapipe/JordiD/results/filteringresults

filter_vep \
	-i veptable_gc_AF1_AD.tab \
	-o canonical_veptable_gc_AF1_AD.tab \
	--format tab \
	--filter "CANONICAL is YES"
