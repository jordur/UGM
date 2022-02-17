#!/bin/sh
#SBATCH --job-name="eval"
#SBATCH --mem=15G
#SBATCH --cpus-per-task 4

module load picard/2.9.2-Java-1.8.0_92
module load GATK/4.2.0.0-Java-1.8.0_92

## Evaluation SNPs ##
java -jar $EBROOTPICARD/picard.jar CollectVariantCallingMetrics INPUT=/home/jperez/pruebapipe/JordiD/results/recalibrated_snps.vcf OUTPUT=/home/jperez/pruebapipe/JordiD/snps_eval.txt DBSNP=/home/jperez/ref/JordiD/Homo_sapiens_assembly38.dbsnp138.vcf THREAD_COUNT=4
#
java -jar $EBROOTPICARD/picard.jar CollectVariantCallingMetrics INPUT=/home/jperez/pruebapipe/JordiD/results/recalibrated_indels.vcf OUTPUT=/home/jperez/pruebapipe/JordiD/indel_eval.txt DBSNP=/home/jperez/ref/JordiD/Homo_sapiens_assembly38.dbsnp138.vcf THREAD_COUNT=4
#
#java -jar $EBROOTPICARD/picard.jar CollectVariantCallingMetrics INPUT=/home/jperez/pruebapipe/JordiD/final_hardfiltered_snps.vcf OUTPUT=/home/jperez/pruebapipe/JordiD/hardsnps_eval.txt DBSNP=/home/jperez/ref/JordiD/Homo_sapiens_assembly38.dbsnp138.vcf THREAD_COUNT=4
#
#java -jar $EBROOTPICARD/picard.jar CollectVariantCallingMetrics INPUT=/home/jperez/pruebapipe/JordiD/final_hardfiltered_indels.vcf OUTPUT=/home/jperez/pruebapipe/JordiD/hardindels_eval.txt DBSNP=/home/jperez/ref/JordiD/Homo_sapiens_assembly38.dbsnp138.vcf THREAD_COUNT=4


#### Coverage GATK ####
#gatk DepthOfCoverage \
#	-R /home/jperez/ref/JordiD/Homo_sapiens_assembly38.fasta \
#	-I /home/jperez/pruebapipe/JordiD/results/MCI/0596/0596_recal_reads.bam \
#	-O /home/jperez/pruebapipe/JordiD/results/MCI/0596/cov_stats \
#	-L /home/jperez/ref/JordiD/clinical_exome.bed
#	
