#output local maxima, thresholded images, all images for t=1.65 
##for composite only
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o age+sex+meanFD+composite.mdmr/cluster_correction_output/t1.65_p0.05/cluster_index_composite_only \
--othresh=age+sex+meanFD+composite.mdmr/cluster_correction_output/t1.65_p0.05/thresholded_image_composite_only \
--olmax=age+sex+meanFD+composite.mdmr/cluster_correction_output/t1.65_p0.05/local_maxima_composite_only \
--olmaxim=age+sex+meanFD+composite.mdmr/cluster_correction_output/t1.65_p0.05/local_maxima_composite_only \
--osize=age+sex+meanFD+composite.mdmr/cluster_correction_output/t1.65_p0.05/cluster_size_composite_only \
--omax=age+sex+meanFD+composite.mdmr/cluster_correction_output/t1.65_p0.05/cluster_max_composite_only \
--omean=age+sex+meanFD+composite.mdmr/cluster_correction_output/t1.65_p0.05/cluster_mean_composite_only \
> age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_list_composite_only.txt
