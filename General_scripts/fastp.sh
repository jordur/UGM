#!/bin/sh
#SBATCH --job-name="faidx"
module load FastQC/0.11.8-Java-1.8.0_92
module load fastp/0.20.1-foss-2016b

#fastqc
#for i in EX58_SM001577-88_S7_L001_R1_001.fastq.gz EX58_SM001577-88_S7_L001_R2_001.fastq.gz; do
#fastqc /home/jperez/pruebapipe/L-140/${i} -o /home/jperez/pruebapipe/JordiD/QC; done


fastqc /home/jperez/samplesTest/L-124/EX58_SM001577-83_S3_L001_R1_001.fastq.gz -o /home/jperez/pruebapipe/JordiD/QC
fastqc  /home/jperez/samplesTest/L-124/EX58_SM001577-83_S3_L001_R2_001.fastq.gz -o /home/jperez/pruebapipe/JordiD/QC
