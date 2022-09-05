#!/bin/sh
#SBATCH --job-name="table"
#SBATCH --mem=50G

module load picard/2.23.8-Java-1.8.0_92
module load GATK/4.2.0.0-Java-1.8.0_92
module load SAMtools/1.10-foss-2016b
module load R/4.0.2-foss-2016b-X11-20160819

echo $(date)

gatk IndexFeatureFile \
       -I   /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_severe_vep_conseq.vcf\
	-I /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_assymp_vep_conseq.vcf \
	-I /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_moderate_vep_conseq.vcf

gatk VariantsToTable \
               -V /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_severe_vep_conseq.vcf \
               -O /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_severe_vep_conseq.counts \
               -F CHROM -F POS -F HET -F HOM-REF -F HOM-VAR -F NO-CALL -F NCALLED
gatk VariantsToTable \
               -V /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_assymp_vep_conseq.vcf \
               -O /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_assymp_vep_conseq.counts \
               -F CHROM -F POS -F HET -F HOM-REF -F HOM-VAR -F NO-CALL -F NCALLED

gatk VariantsToTable \
               -V /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_moderate_vep_conseq.vcf \
               -O /home/jperez/COVID19/results/pipeline/recalibrated_variants_DP20_gatk_het_moderate_vep_conseq.counts \
               -F CHROM -F POS -F HET -F HOM-REF -F HOM-VAR -F NO-CALL -F NCALLED

#
#
#
#
#for i in MCI AD control ALL; do
#	gatk VariantsToTable \
#	        -V /home/jperez/pruebapipe/JordiD/results/pipeline/recalibrated_variants_DP20_gatk_het_${i}_vep.vcf \
#        	-O /home/jperez/pruebapipe/JordiD/results/pipeline/counts/recalibrated_variants_DP20_gatk_het_${i}_vep.counts \
#		-F CHROM -F POS -F HET -F HOM-REF -F HOM-VAR -F NO-CALL
#
#	gatk VariantsToTable \
#                -V /home/jperez/pruebapipe/JordiD/results/pipeline/gene_conseq_variants_DP20_gatk_het_${i}_vep.vcf \
#                -O /home/jperez/pruebapipe/JordiD/results/pipeline/counts/gene_conseq_variants_DP20_gatk_het_${i}_vep.counts \
#                -F CHROM -F POS -F HET -F HOM-REF -F HOM-VAR -F NO-CALL
#	for j in 1 5; do
#		
#		gatk VariantsToTable \
#                	-V /home/jperez/pruebapipe/JordiD/results/pipeline/ADgenes_variants_DP20_gatk_het_${i}_vep_af${j}.vcf \
#	                -O /home/jperez/pruebapipe/JordiD/results/pipeline/counts/ADgenes_variants_DP20_gatk_het_${i}_vep_af${j}.counts \
#	                -F CHROM -F POS -F HET -F HOM-REF -F HOM-VAR -F NO-CALL
#
#		gatk VariantsToTable \
#                        -V /home/jperez/pruebapipe/JordiD/results/pipeline/recalibrated_variants_DP20_gatk_het_${i}_vep_af${j}.vcf \
#                        -O /home/jperez/pruebapipe/JordiD/results/pipeline/counts/recalibrated_variants_DP20_gatk_het_${i}_vep_af${j}.counts \
#                        -F CHROM -F POS -F HET -F HOM-REF -F HOM-VAR -F NO-CALL
#
#
#	done
#done
