##try in parallel?
cd /data/jet/kable/Ursula
Rscript /home/utooley/connectir-master/inst/scripts/connectir_subdist.R \
-i functional_images_list_wo_outliers.txt \
--automask1 \
--memlimit 40 -c 4 \
--ztransform \
--brainmask1 GreyMask_v2_4mm.nii \
--bg rsingle_subj_T1.nii sub_dist_with_zscored_4mmbg
