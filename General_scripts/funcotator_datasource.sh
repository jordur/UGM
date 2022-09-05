#!/bin/bash
#SBATCH --job-name=AD
#SBATCH --partition=fast
#SBATCH --cpus-per-task 2 #"-c"
#SBATCH --mem 5G
#SBATCH -N 2
#SBATCH --output=AD_%A_%a.out
#SBATCH --error=AD_%A_%a.err
module load GATK/4.1.7.0-Java-1.8.0_92

$EBROOTGATK/gatk FuncotatorDataSourceDownloader --germline --validate-integrity --extract-after-download
