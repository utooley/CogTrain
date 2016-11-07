cd /Users/utooley/Documents/Kable_Lab/CogTrain/CWAS
Rscript ./connectir_mdmr.R -i subj_dist_with_zscore \
    --formula "age + sex + mean.FD + composite + csh_residual_variance" \
    --model demo_and_EF_MDMR_regressors_110416.csv \
    --factors2perm "composite, csh_residual_variance" \
    --permutations 14999 \
    --forks 1 --threads 12 \
    --memlimit 15 \
    --save-perms \
    --ignoreprocerror \
    mdmr_age+sex+mean.FD+composite+switch.mdmr