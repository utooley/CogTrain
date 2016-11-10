cd /data/jet/kable/Ursula/
Rscript /home/utooley/connectir-master/inst/scripts/connectir_mdmr.R -i sub_dist_with_zscored \
    --formula "composite + cshresidualvariance + vnbresidualvariance + meanFD + age + sex" \
    --model regressors_agesexFD_cogupdateswitch_111016.csv \
    --factors2perm composite \
    --permutations 14999 \
    --forks 5 \
    --memlimit 30 \
    --save-perms \
    --ignoreprocerror \
age+sex+meanFD+composite+update+switch.mdmr