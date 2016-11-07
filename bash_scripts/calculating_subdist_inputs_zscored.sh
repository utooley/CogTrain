#!/bin/bash 
cd /Users/utooley/Documents/Kable_Lab/CogTrain/CWAS
/Users/utooley/Documents/Kable_Lab/CogTrain/CogTrain/R_scripts/connectir-master/inst/scripts/connectir_subdist.R \
-i functional_images_list_wo_outliers.txt \
--automask1 \
--memlimit 35 \
--ztransform \
--brainmask1 GreyMask_v2_4mm.nii \
--bg single_subj_T1.nii 


##running on the cluster
cd /data/jet/kable/Ursula
Rscript /home/utooley/connectir-master/inst/scripts/connectir_subdist.R \
-i functional_images_list.txt \
--automask1 \
--memlimit 4 \
--ztransform \
--brainmask1 GreyMask_v2_4mm.nii \
--bg single_subj_T1.nii sub_dist_with_zscored

##try in parallel?
cd /data/jet/kable/Ursula
Rscript /home/utooley/connectir-master/inst/scripts/connectir_subdist.R \
-i functional_images_list.txt \
--automask1 \
--memlimit 40 -c 3 \
--ztransform \
--brainmask1 GreyMask_v2_4mm.nii \
--bg single_subj_T1.nii sub_dist_with_zscored
