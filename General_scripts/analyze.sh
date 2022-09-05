#!/bin/sh
#SBATCH --job-name="covariates"
#SBATCH --mem=50G

module load R/4.0.2-foss-2016b-X11-20160819
module load GATK/4.2.0.0-Java-1.8.0_92

## Analyze Covariates ##
gatk AnalyzeCovariates \
        -before /home/jperez/pruebapipe/JordiD/results/Dementia-AD/L-059-4/L-059-4_recal_data.table \
        -after /home/jperez/pruebapipe/JordiD/results/Dementia-AD/L-059-4/L-059-4_post_recal_data.table \
        -plots /home/jperez/pruebapipe/JordiD/results/Dementia-AD/L-059-4/L-059-4_recalibration_plots.pdf
