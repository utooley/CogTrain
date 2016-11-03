#!/bin/bash 
cd /Users/utooley/Documents/Kable_Lab/CogTrain/CWAS
/Users/utooley/Documents/Kable_Lab/CogTrain/CogTrain/R_scripts/connectir-master/inst/scripts/connectir_subdist.R \
-i functional_images_list_wo_outliers.txt \
--automask1 \
--memlimit 35 \
--ztransform \
--brainmask1 GreyMask_v2_4mm.nii \
--bg single_subj_T1.nii sub_dist_with_zscored