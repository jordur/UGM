#!/bin/sh
#SBATCH --job-name="combine_gvcf"
#SBATCH --mem=20G
#SBATCH --cpus-per-task 8

module load R/4.0.2-foss-2016b-X11-20160819
module load GATK/4.2.0.0-Java-1.8.0_92

## combine gvcfs ##
gatk CombineGVCFs \
	-R ${refDir}/Homo_sapiens_assembly38.fasta \
	--variant ${outDir}/gvcfs/L-006-2.g.vcf \
    	--variant ${outDir}/gvcfs/L-012-3.g.vcf \
	--variant ${outDir}/gvcfs/L-014-2.g.vcf \
	--variant ${outDir}/gvcfs/L-029-2.g.vcf \
	--variant ${outDir}/gvcfs/L-031-2.g.vcf \
	--variant ${outDir}/gvcfs/L-038-3.g.vcf \
	--variant ${outDir}/gvcfs/L-042.g.vcf \
	--variant ${outDir}/gvcfs/L-052.g.vcf \
	--variant ${outDir}/gvcfs/L-059-4.g.vcf \
	--variant ${outDir}/gvcfs/L-068-3.g.vcf \
	--variant ${outDir}/gvcfs/L-070.g.vcf \
	--variant ${outDir}/gvcfs/L-076.g.vcf \
	--variant ${outDir}/gvcfs/L-077.g.vcf \
	--variant ${outDir}/gvcfs/L-081-3.g.vcf \
	--variant ${outDir}/gvcfs/L-083.g.vcf \
	--variant ${outDir}/gvcfs/L-089-2.g.vcf \
	--variant ${outDir}/gvcfs/L-091-2.g.vcf \
	--variant ${outDir}/gvcfs/L-094.g.vcf \
	--variant ${outDir}/gvcfs/L-095-10.g.vcf \
	--variant ${outDir}/gvcfs/L-098-2.g.vcf \
	--variant ${outDir}/gvcfs/L-102.g.vcf \
	--variant ${outDir}/gvcfs/L-108-3.g.vcf \
	--variant ${outDir}/gvcfs/L-111.g.vcf \
	--variant ${outDir}/gvcfs/L-115.g.vcf \
	--variant ${outDir}/gvcfs/L-116.g.vcf \
	--variant ${outDir}/gvcfs/L-117-2.g.vcf \
	--variant ${outDir}/gvcfs/L-118.g.vcf \
	--variant ${outDir}/gvcfs/L-119.g.vcf \
	--variant ${outDir}/gvcfs/L-122.g.vcf \
	--variant ${outDir}/gvcfs/L-124.g.vcf \
	--variant ${outDir}/gvcfs/L-126-2.g.vcf \
	--variant ${outDir}/gvcfs/L-127-2.g.vcf \
	--variant ${outDir}/gvcfs/L-128.g.vcf \
	--variant ${outDir}/gvcfs/L-129.g.vcf \
	--variant ${outDir}/gvcfs/L-140.g.vcf \
	--variant ${outDir}/gvcfs/L-141-2.g.vcf \
	--variant ${outDir}/gvcfs/L-142.g.vcf \
	--variant ${outDir}/gvcfs/L-143.g.vcf \
	--variant ${outDir}/gvcfs/L-144.g.vcf \
	--variant ${outDir}/gvcfs/L-147.g.vcf \
	--variant ${outDir}/gvcfs/L-148.g.vcf \
	--variant ${outDir}/gvcfs/L-149.g.vcf \
	--variant ${outDir}/gvcfs/L-150.g.vcf \
	--variant ${outDir}/gvcfs/L-151.g.vcf \
	--variant ${outDir}/gvcfs/L-154.g.vcf \
	--variant ${outDir}/gvcfs/L-155.g.vcf \
	--variant ${outDir}/gvcfs/L-158.g.vcf \
	--variant ${outDir}/gvcfs/0033.g.vcf \
	--variant ${outDir}/gvcfs/0152.g.vcf \
	--variant ${outDir}/gvcfs/0213.g.vcf \
	--variant ${outDir}/gvcfs/0270.g.vcf \
	--variant ${outDir}/gvcfs/0308.g.vcf \
	--variant ${outDir}/gvcfs/0372.g.vcf \
	--variant ${outDir}/gvcfs/0572.g.vcf \
	--variant ${outDir}/gvcfs/0596.g.vcf \
	--variant ${outDir}/gvcfs/0611.g.vcf \
	--variant ${outDir}/gvcfs/0637.g.vcf \
	--variant ${outDir}/gvcfs/0643.g.vcf \
	--variant ${outDir}/gvcfs/0807.g.vcf \
	--variant ${outDir}/gvcfs/0850.g.vcf \
	--variant ${outDir}/gvcfs/1083.g.vcf \
	--variant ${outDir}/gvcfs/1202.g.vcf \
	--variant ${outDir}/gvcfs/1209.g.vcf \
	-O ${outDir}/cohort.g.vcf.gz


## Combine gvcfs (automático)

#habría que tener en cuenta el directorio desde el que se ejecuta este script para que el resto también funcione
./combine_txt.sh ${outDir}/gvcfs/
./combScript.sh

## GenotypeGCVCF ##
	
gatk GenotypeGVCFs \
	-R ${refDir}/Homo_sapiens_assembly38.fasta \
	-V ${outDir}/cohort.g.vcf.gz \
	-O ${outDir}/raw_variants.vcf


### VQSR ##	

sbatch -p normal --dependency=afterok:${SLURM_JOB_ID} /home/jperez/scripts/JordiD/vqsr.sh

echo $(date)
