plink --bfile commonvars_allgenes_clean_pruned --fam commonvars_allgenes_clean_pruned.fam --keep AD-control.args --make-bed --out commonvars_allgenes_clean_pruned_AD-control 
plink --bfile commonvars_allgenes_clean_pruned --fam commonvars_allgenes_clean_pruned.fam --keep MCI-control.args --make-bed --out commonvars_allgenes_clean_pruned_MCI-control
plink --bfile commonvars_allgenes_clean_pruned --fam commonvars_allgenes_clean_pruned.fam --keep AD-MCI.args --make-bed --out commonvars_allgenes_clean_pruned_AD-MCI

plink --bfile commonvars_allgenes_clean_pruned_AD-control --fam commonvars_allgenes_AD-control.fam --model --out AD-control
plink --bfile commonvars_allgenes_clean_pruned_MCI-control --fam commonvars_allgenes_MCI-control.fam --model --out MCI-control
plink --bfile commonvars_allgenes_clean_pruned_AD-MCI --fam commonvars_allgenes_AD-MCI.fam --model --out AD-MCI
