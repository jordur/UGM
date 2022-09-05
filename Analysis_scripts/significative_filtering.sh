awk '{if ($5 < 0.05 && $6 > 0.05 && $7 < 0.05){print}}' Merged_results_common_variants.tsv > ./sign/commbtwADMCI_commonvars.tsv 
awk '{if ($5 < 0.05 && $6 > 0.05 && $7 < 0.05){print}}' Merged_results_lessfreq_variants.tsv > ./sign/commbtwADMCI_lessfreq.tsv
awk '{if ($5 < 0.05 && $6 > 0.05 && $7 < 0.05){print}}' Merged_results_rare_variants.tsv > ./sign/commbtwADMCI_rarevars.tsv
awk '{if ($5 > 0.05 && $6 < 0.05 && $7 > 0.05){print}}' Merged_results_rare_variants.tsv > ./sign/diffbtwADMCI_rarevars.tsv
awk '{if ($5 > 0.05 && $6 < 0.05 && $7 > 0.05){print}}' Merged_results_lessfreq_variants.tsv > ./sign/diffbtwADMCI_lessfreq.tsv
awk '{if ($5 > 0.05 && $6 < 0.05 && $7 > 0.05){print}}' Merged_results_common_variants.tsv > ./sign/diffbtwADMCI_commonvars.tsv

#cat ./rePRS/vars_prep/diffbtwADMCI_commonvars.txt ./rePRS/vars_prep/commbtwADMCI_commonvars.txt > ./rePRS/vars_prep/combined_variants_common.txt
#./rePRS/vars_prep/trying2getvars.R

#cat ./rePRS/vars_prep/combined_* > ./rePRS/vars_prep/all_cosas.txt
#awk '{print $1}' ./rePRS/vars_prep/all_cosas.txt > ./rePRS/variants_PRS.txt
