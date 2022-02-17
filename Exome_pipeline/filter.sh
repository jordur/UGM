#!/bin/sh
#SBATCH --job-name="filter"

echo $(date)

for i in ALL MCI AD control; do
		FILE=${outDir}/recalibrated_variants_DP20_gatk_het_${i}.vcf
		if [ -f "$FILE" ]; then
		    echo "$FILE exists. Going to VEP annotation!"
			sbatch -p normal ${scrDir}/annotate_${i}.sh
		else

			### Filter variants by Depth and Genome Quality##
			gatk VariantFiltration \
		        	-R ${refDir}/${assembly}/Homo_sapiens_assembly.fasta \
			        -V ${outDir}/recalibrated_variants.vcf \
			        -O ${outDir}/recalibrated_variants_DP20_gatk.vcf \
			        -genotype-filter-name "Depth" -genotype-filter-expression "DP < 20" \
				--set-filtered-genotype-to-no-call true \
				-genotype-filter-name "GQ" -genotype-filter-expression "GQ < 20" 
		
			## Getting control genotypes (at least 1 called && at least 1 VAR allele & BIALLELIC)
			gatk SelectVariants \
				-R ${refDir}/${assembly}/Homo_sapiens_assembly.fasta \
				-V ${outDir}/recalibrated_variants_DP20_gatk.vcf \
				-L ${refDir}/Exome_V6.bed \
				-O ${outDir}/recalibrated_variants_DP20_gatk_het_control.vcf \
				--exclude-sample-name ${outDir}/MCI.args \
				--exclude-sample-name ${outDir}/AD.args \
			 	-select 'vc.getCalledChrCount() != 0 && (vc.getHetCount() >= 1 or vc.getHomVarCount() >= 1)'  \
				--restrict-alleles-to BIALLELIC \
				--exclude-filtered true
			
			## Getting AD genotypes (at least 1 called && at least 1 VAR allele & BIALLELIC)
			gatk SelectVariants \
			        -R ${refDir}/${assembly}/Homo_sapiens_assembly.fasta \
		        	-V ${outDir}/recalibrated_variants_DP20_gatk.vcf \
			        -L ${refDir}/Exome_V6.bed \
			        -O ${outDir}/recalibrated_variants_DP20_gatk_het_AD.vcf \
			        --exclude-sample-name ${outDir}/control.args \
		        	--exclude-sample-name ${outDir}/MCI.args \
				-select 'vc.getCalledChrCount() != 0 && (vc.getHetCount() >= 1 or vc.getHomVarCount() >= 1)' \
			        --restrict-alleles-to BIALLELIC \
			        --exclude-filtered true
		
			## Getting MCI genotypes (at least 1 called && at least 1 VAR allele & BIALLELIC)
			gatk SelectVariants \
			        -R ${refDir}/${assembly}/Homo_sapiens_assembly.fasta \
			        -V ${outDir}/recalibrated_variants_DP20_gatk.vcf \
			        -L ${refDir}/Exome_V6.bed \
			        -O ${outDir}/recalibrated_variants_DP20_gatk_het_MCI.vcf \
			        --exclude-sample-name ${outDir}/control.args \
			        --exclude-sample-name ${outDir}/AD.args \
				-select 'vc.getCalledChrCount() != 0 && (vc.getHetCount() >= 1 or vc.getHomVarCount() >= 1)' \
		        	--restrict-alleles-to BIALLELIC \
			        --exclude-filtered true

			gatk SelectVariants \
                                -R ${refDir}/${assembly}/Homo_sapiens_assembly.fasta \
                                -V ${outDir}/recalibrated_variants_DP20_gatk.vcf \
                                -L ${refDir}/Exome_V6.bed \
                                -O ${outDir}/recalibrated_variants_DP20_gatk_het_ALL.vcf \
                                -select 'vc.getCalledChrCount() != 0 && (vc.getHetCount() >= 1 or vc.getHomVarCount() >= 1)' \
                                --restrict-alleles-to BIALLELIC \
                                --exclude-filtered true

			sbatch -p normal --dependency=afterok:${SLURM_JOB_ID} ${scrDir}/annotate_${i}.sh
		fi
done

echo $(date)

