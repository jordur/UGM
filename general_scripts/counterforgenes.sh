#!/bin/bash
input="./../../../ref/ADgenes.txt"
while read gene; do
	counter=$(cat ./filteringresults/genes_conseq_recalibrated_control_DP20_gatk_het_vep_gnomAD1.vcf | grep -c $gene)
	echo "$gene	$counter"
done < $input
		
