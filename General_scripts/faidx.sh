#!/bin/sh
#SBATCH --job-name="faidx"
module load SAMtools/1.10-foss-2016b
module load picard/2.23.8-Java-1.8.0_92

samtools faidx /home/jperez/pruebapipe/JordiD/ref/Homo_sapiens_assembly38.fasta 
java -jar $EBROOTPICARD/picard.jar CreateSequenceDictionary -R /home/jperez/pruebapipe/JordiD/ref/Homo_sapiens_assembly38.fasta -O /home/jperez/pruebapipe/JordiD/ref/Homo_sapiens_assembly38.dict
