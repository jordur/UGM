#!/bin/sh
#SBATCH --job-name="combine_gvcf"
#SBATCH --mem=20G
#SBATCH --cpus-per-task 8

### Añadir archivos control para saltar funciones ###
FILE=${outDir}/raw_variants.vcf
if [ -f "$FILE" ]; then
    echo "$FILE exists."
    sbatch -D ${outDir}/gvcfs -p normal ${scrDir}/vqsr.sh
    exit
fi

## combine gvcfs ##
gatk CombineGVCFs \
	-R ${refDir}/${assembly}/Homo_sapiens_assembly.fasta \
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
	--variant ${outDir}/gvcfs/0039.g.vcf \
	--variant ${outDir}/gvcfs/0069.g.vcf \
	--variant ${outDir}/gvcfs/0104.g.vcf \
	--variant ${outDir}/gvcfs/0115-6.g.vcf \
	--variant ${outDir}/gvcfs/0155.g.vcf \
	--variant ${outDir}/gvcfs/0180.g.vcf \
	--variant ${outDir}/gvcfs/0202.g.vcf \
	--variant ${outDir}/gvcfs/0217.g.vcf \
	--variant ${outDir}/gvcfs/0259.g.vcf \
	--variant ${outDir}/gvcfs/0276.g.vcf \
	--variant ${outDir}/gvcfs/0477.g.vcf \
	--variant ${outDir}/gvcfs/0538.g.vcf \
	--variant ${outDir}/gvcfs/0552.g.vcf \
	--variant ${outDir}/gvcfs/0591.g.vcf \
	--variant ${outDir}/gvcfs/0606-6.g.vcf \
	--variant ${outDir}/gvcfs/0638.g.vcf \
	--variant ${outDir}/gvcfs/0732.g.vcf \
	--variant ${outDir}/gvcfs/0771.g.vcf \
	--variant ${outDir}/gvcfs/0870.g.vcf \
	--variant ${outDir}/gvcfs/0925.g.vcf \
	--variant ${outDir}/gvcfs/0982.g.vcf \
	--variant ${outDir}/gvcfs/1048.g.vcf \
	-O ${outDir}/cohort.g.vcf.gz

## GenotypeGCVCF ##
	
gatk GenotypeGVCFs \
	-R ${refDir}/${assembly}/Homo_sapiens_assembly.fasta \
	-V ${outDir}/cohort.g.vcf.gz \
	-O ${outDir}/raw_variants.vcf


### VQSR ##	

sbatch -p normal --dependency=afterok:${SLURM_JOB_ID} ${scrDir}/vqsr.sh

echo $(date)