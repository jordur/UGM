sed -i 's/X//g' test_samples.tsv
sed -i 's/\./-/g' test_samples.tsv
tail -n +2 test_samples.tsv | awk '{print $1, $1}' > plink_test_samples.fam
plink --bfile selected --keep plink_test_samples.fam --make-bed --out selectedvars_testsample
plink --bfile selectedvars_testsample --score validation_df2.tsv header 1 5 2 --out validation-scoring
