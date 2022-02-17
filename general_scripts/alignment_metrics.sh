#!/bin/sh
#SBATCH --job-name="metrics"
#SBATCH --mem=50G


# Collect Alignment & Insert Size Metrics
java -jar $EBROOTPICARD/picard.jar CollectAlignmentSummaryMetrics R=/home/jperez/ref/JordiD/Homo_sapiens_assembly38.fasta I=/home/jperez/pruebapipe/sorted_dedup_reads.bam O=/home/jperez/pruebapipe/
