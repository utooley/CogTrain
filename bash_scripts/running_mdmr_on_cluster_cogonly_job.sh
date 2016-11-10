cd /data/jet/kable/Ursula/
Rscript /home/utooley/connectir-master/inst/scripts/connectir_mdmr.R -i sub_dist_with_zscored \
    --formula "composite + meanFD + age + sex" \
    --model only_necessary_regressors_agesexFDcog_111016.csv \
    --factors2perm composite \
    --permutations 14999 \
    --forks 4 \
    --memlimit 40 \
    --save-perms \
    --ignoreprocerror \
age+sex+meanFD+composite.mdmr