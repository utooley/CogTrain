##Calculating dlh and smoothness with FSL
smoothest --zstat=sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite+update+switch_allpermuted.mdmr/zstats_cshresidualvariance.nii --mask=GreyMask_v2_4mm.nii 

##old AFNI should be performing one-sided testing, so pthreshold=0.05 is same as thresholding at z=1.64
3dClustSim -mask mask.nii -fwhmxyz 8.37794 8.04997 8.68879 -pthr 0.05 -athr .05 .01 \
-iter 10000 -nodec -NN 123 -prefix cluster_size_needed

##pull out clusters with (d from combined mask)
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.447972 \
--volume=20169 --minclustersize \
-o cluster_indexes_combinedm_composite_only > clusters_composite_combined_mask.txt

##do the same thing with cluster in FSL (d from calculating smoothness from grey mask only)
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o cluster_indexes_greym_composite_only > clusters_composite_grey_mask.txt

##do the same thing with cluster in FSL, add min of 20 mm between maxima/minima as in Shehzad
##pull out clusters with (d from grey mask only)
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize --peakdist=20 \
-o age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_indexes_greym_composite_20mindist > age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_composite_grey_mask_20mindist.txt


##FOR MDMR co-varying updating and switch residuals
cluster -i age+sex+meanFD+composite+update+switch.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o age+sex+meanFD+composite+update+switch.mdmr/cluster_correction_output/cluster_indexe_greym_composite_covaried > age+sex+meanFD+composite+update+switch.mdmr/cluster_correction_output/clusters_composite_covaried_grey_mask.txt


##FOR MDMR permuting switch and updating residuals--switch residual
cluster -i age+sex+meanFD+composite+update+switch_allpermuted.mdmr/zstats_cshresidualvariance.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/cluster_index_greym_switching_covaried > age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/clusters_switching_covaried_grey_mask.txt

##FOR MDMR permuting switch and updating residuals--updating residual
cluster -i age+sex+meanFD+composite+update+switch_allpermuted.mdmr/zstats_vnbresidualvariance.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/cluster_index_greym_updating_covaried > age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/clusters_updating_covaried_grey_mask.txt

##FOR MDMR permuting switch and updating residuals--COMPOSITE RESIDUAL CHECK THESE AGAINST ORIGINAL COMPOSITE CLUSTER CORRECTION
cluster -i age+sex+meanFD+composite+update+switch_allpermuted.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/cluster_index_greym_composite_covaried > age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/clusters_composite_covaried_grey_mask.txt
