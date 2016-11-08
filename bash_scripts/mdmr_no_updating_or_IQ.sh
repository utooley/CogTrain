cd /data/jet/kable/Ursula/
Rscript /home/utooley/connectir-master/inst/scripts/connectir_mdmr.R -i sub_dist_with_zscored \
    --formula "age + sex + mean.FD + composite + csh_residual_variance" \
    --model demo_and_EF_MDMR_regressors_110416.csv \
    --factors2perm "composite, csh_residual_variance" \
    --permutations 14999 \
    --forks 4 \
    --memlimit 40 \
    --save-perms \
    --ignoreprocerror \
    mdmr_age+sex+mean.FD+composite+switch.mdmr
    
##interactive w/ just 4 subjects
cd /data/jet/kable/Ursula/
Rscript /home/utooley/connectir-master/inst/scripts/connectir_mdmr.R -i sub_dist_with_zscored_t2 \
    --formula "age + sex + mean.FD + composite" \
    --model demo_and_EF_MDMR_regressors_110416_4sub.csv \
    --factors2perm "composite" \
    --permutations 14999 \
    --forks 4 \
    --memlimit 40 \
    --save-perms \
    --ignoreprocerror \
mdmr_age+sex+mean.FD+composite+switch_4sub.mdmr