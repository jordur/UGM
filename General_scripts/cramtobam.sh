#!/bin/sh
#SBATCH --job-name="cramtobam"

module load SAMtools/1.10-foss-2016b

samtools view -b  -T /home/jperez/pruebapipe/JordiD/ref/Homo_sapiens_assembly38.fasta -o /home/jperez/ref/1000G/HG00${SLURM_ARRAY_TASK_ID}.alt_bwamem_GRCh38DH.20150826.GBR.exome.bam /home/jperez/ref/1000G/HG00${SLURM_ARRAY_TASK_ID}.alt_bwamem_GRCh38DH.20150826.GBR.exome.cram

