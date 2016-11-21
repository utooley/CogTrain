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
cluster --zstat=cluster_correct_v05_c05/clust_logp_composite.nii -t 1

cd /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite+update+switch.mdmr
3dExtrema -prefix extrem -volume -closure cluster_correct_v05_c05/clust_logp_composite.nii 

#with sep dist of 20 mm
3dExtrema -prefix extrem -volume -sep_dist 20 -closure cluster_correct_v05_c05/clust_logp_composite.nii 

#peaks on boundary or no= with or without -closure 