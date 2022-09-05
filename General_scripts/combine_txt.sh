#!/bin/bash

gvcfDir=$1

## Escribimos el comando de VEP

echo 'gatk CombineGVCFs \
	-R ${refDir}/Homo_sapiens_assembly38.fasta \' > combScript.sh

for gvcf in ${gvcfDir}/*.g.vcf; do
	echo "	--variant ${outDir}/gvcfs/${gvcf}.g.vcf \\" >> combScript.sh
done

echo '	-O ${outDir}/cohort_control.g.vcf.gz' >> combScript.sh

chmod +x combScript.sh
