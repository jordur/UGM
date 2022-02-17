#!/bin/sh
#SBATCH --job-name="skato"
#SBATCH --mem=100G

module load R/4.0.2-foss-2016b-X11-20160819

Rscript /home/jperez/scripts/JordiD/skato.R
