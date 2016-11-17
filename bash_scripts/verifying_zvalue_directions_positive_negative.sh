##check that it's only thresholding positive z-values by looking at mininma
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize --min \
-o age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_indexes_greym_composite_only_minima \
--othresh=age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_thresholded_greym_composite_only_minima \
--olmax=age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_greym_composite_only_local_minima \
--olmaxim=age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_greym_composite_only_local_minima \
 > age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_composite_grey_mask_minima.txt

##check that it's only thresholding positive z-values by looking at 1-pval maps
cluster -i age+sex+meanFD+composite.mdmr/one_minus_pvals_composite.nii -t 0.95 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_indexes_greym_composite_only_pvals_image \
--othresh=age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_thresholded_greym_composite_pvals_image \
--olmax=age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_greym_composite_only_pvals_image \
--olmaxim=age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_greym_composite_only_pvals_image \
 > age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_composite_grey_mask_pvals_image.txt


##TRY AFNI 3dExtrema to check for min and max values
3dExtrema -prefix e -session -data_thr 1.645 -minima age+sex+meanFD+composite.mdmr/zstats_composite.nii