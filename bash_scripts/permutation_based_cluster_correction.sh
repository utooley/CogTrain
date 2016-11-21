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

#using cluster to extract everything in thresholded z-stats file, n of peaks=40
cluster --zstat=cluster_correct_v05_c05/extracting_peaks/composite_zstats_masked_with_v05c05_corrected.nii \
-t 1 -n 40 --olmax=cluster_correct_v05_c05/extracting_peaks/clust_maxima_z_40peaks_sepdist20.txt --olmaxim=cluster_correct_v05_c05/extracting_peaks/clust_maximum_z_image_40peaks_sepdist20

#using cluster to extract everything in thresholded logp_composite file, n of peaks=40, sep_dist=20
cluster --zstat=cluster_correct_v05_c05/clust_logp_composite.nii \
-t 1 -n 40 --peakdist=20 --olmax=cluster_correct_v05_c05/extracting_peaks/clust_maxima_logp_40peaks_sepdist20.txt --olmaxim=cluster_correct_v05_c05/extracting_peaks/clust_maximum_image_40peaks_sepdist20


cd /data/jet/kable/Ursula/sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite+update+switch.mdmr/cluster_correct_v05_c05/
3dExtrema -volume -closure clust_logp_composite.nii > extracting_peaks/3dextrema_logp_peaks_all.txt

#only print first n
3dExtrema -volume -closure -nbest 40 clust_logp_composite.nii > extracting_peaks/3dextrema_logp_peaks_40peaks.txt

#with sep dist of 20 mm
3dExtrema -volume -closure -sep_dist 20 clust_logp_composite.nii > extracting_peaks/3dextrema_logp_peaks_all_sepdist20.txt

#try masking zstat image with significant voxels from corrected cluster image and then running cluster to extract clusters and local maxima
fslmaths cluster_correct_v05_c05/clust_composite.nii -thr 1 -bin -mul zstats_composite.nii cluster_correct_v05_c05/zstats_masked_by_clustercorrected

##can break up clusters more by using a higher threshold (i.e. above 2 for z-image)
cluster --in=zstats_masked_by_clustercorrected.nii.gz --thresh=0.0001 --oindex=zstats_masked_by_clustercorrected_clustindex --olmax=zstats_masked_by_clustercorrected_lmax.txt