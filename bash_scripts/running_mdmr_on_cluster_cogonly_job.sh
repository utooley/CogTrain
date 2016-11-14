cd /data/jet/kable/Ursula/
Rscript /home/utooley/connectir-master/inst/scripts/connectir_mdmr.R -i sub_dist_with_zscored_4mmbg \
    --formula "composite + meanFD + age + sex" \
    --model only_necessary_regressors_agesexFDcog_111016.csv \
    --factors2perm composite \
    --permutations 14999 \
    --forks 5 \
    --memlimit 40 \
    --save-perms \
    --ignoreprocerror \
age+sex+meanFD+composite.mdmr