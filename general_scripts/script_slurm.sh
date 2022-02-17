#!/bin/bash
#SBATCH --job-name=AD
#SBATCH --partition=fast
#SBATCH --cpus-per-task 2 #"-c"
#SBATCH --mem 5G
#SBATCH -N 2
#SBATCH --output=AD_%A_%a.out
#SBATCH --error=AD_%A_%a.err
module load GATK/4.1.7.0-Java-1.8.0_92
module load BWA/0.7.16a-foss-2016b
module load BCFtools/1.10.2-foss-2016b
module load SAMtools/1.10-foss-2016b
module load SIFT4G/2.4-Java-1.8.0_92
module load VEP/97.4-foss-2016b-Perl-5.24.0
module load fastp/0.20.1-foss-2016b
module load picard/2.23.8-Java-1.8.0_92
module load tabix/0.2.6-foss-2016b
module load BEDTools/2.29.2-foss-2016b
./vcf_gen.sh
