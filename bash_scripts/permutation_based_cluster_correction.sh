#composite only no covariates
cd /home/utooley/connectir-master/permutation/
Rscript ~/connectir-master/permutation/le_correcter.R /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite.mdmr
#composite w/ covariates
cd /home/utooley/connectir-master/permutation/
Rscript ~/connectir-master/permutation/le_correcter.R /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite+update+switch.mdmr
#all permuted
cd /home/utooley/connectir-master/permutation/
Rscript ~/connectir-master/permutation/le_correcter.R /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite+update+switch_allpermuted.mdmr

#Now extract with 3dExtrema or with cluster?
