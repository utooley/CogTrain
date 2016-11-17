##Calculating dlh and smoothness with FSL
smoothest --zstat=sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite+update+switch_allpermuted.mdmr/zstats_cshresidualvariance.nii --mask=GreyMask_v2_4mm.nii 

##Calculating smoothness with AFNI
3dFWHMx -input sub_dist_with_zscored_4mmbg/age+sex+meanFD+composite+update+switch_allpermuted.mdmr/zstats_vnbresidualvariance.nii -mask GreyMask_v2_4mm.nii

##old AFNI should be performing one-sided testing, so pthreshold=0.05 is same as thresholding at z=1.64
3dClustSim -mask mask.nii -fwhmxyz 8.37794 8.04997 8.68879 -pthr 0.05 -athr .05 .01 \
-iter 10000 -nodec -NN 123 -prefix cluster_size_needed

##do the same thing with cluster in FSL (d from calculating smoothness from grey mask only)
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize \
-o age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_indexes_greym_composite_only \
-othresh=age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_thresholded_greym_composite_only > age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_composite_grey_mask_minima.txt

##do the same thing with cluster in FSL, add min of 20 mm between maxima/minima as in Shehzad
##pull out clusters with (d from grey mask only)
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t 1.65 \
-p 0.05 --dlh=0.528251 \
--volume=20169 --minclustersize --peakdist=20 \
-o age+sex+meanFD+composite.mdmr/cluster_correction_output/cluster_indexes_greym_composite_20mindist > age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_composite_grey_mask_20mindist.txt



##LOOP THROUGH T AND P VALUES OF CLUSTER CORRECTION TO LOOK AT ROBUSTNESS OF RESULTS
#Composite only
for t in 1.65 2.33; do

for i in 0.05 0.01; do

output="age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_${t}_${i}_composite_only"
filename="age+sex+meanFD+composite.mdmr/cluster_correction_output/clusters_list_t${t}_p${i}_composite.txt"
cluster -i age+sex+meanFD+composite.mdmr/zstats_composite.nii -t ${t} \
-p ${i} --dlh=0.528251 \
--volume=20169 --minclustersize \
-o ${output} > ${filename};
echo "$t$i"
echo ${output}
done;
done

#Composite covaried, with new dlh values
for t in 1.65 2.33; do

for i in 0.05 0.01; do

output="age+sex+meanFD+composite+update+switch.mdmr/cluster_correction_output/clusters_${t}_${i}_composite_covaried"
filename="age+sex+meanFD+composite+update+switch.mdmr/cluster_correction_output/clusters_list_t${t}_p${i}__composite_covaried.txt"
cluster -i age+sex+meanFD+composite+update+switch.mdmr/zstats_composite.nii -t ${t} \
-p ${i} --dlh=0.459323 \
--volume=20169 --minclustersize \
-o ${output} > ${filename};
echo "$t$i"
echo ${output}
done;
done

#Composite, Updating, and Switching Permuted
#haven't figured out how to make this part work, just switch dlh values by hand
#for permuted in composite cshresidualvariance vnbresidualvariance; do
#if ["$permuted" == "composite"]; then
#	dlh = 0.457456
#elif ["$permuted" == "cshresidualvariance"]; then
#	dlh=0.212883
#elif ["$permuted" == "vnbresidualvariance"]; then
	dlh=0.525712
#else
#	echo "no match"
#	exit 1
#fi
	
for t in 1.65 2.33; do

for i in 0.05 0.01; do

output="age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/clusters_${t}_${i}_cshresidualvariance_covaried"
filename="age+sex+meanFD+composite+update+switch_allpermuted.mdmr/cluster_correction_output/clusters_list_t${t}_p${i}_cshresidualvariance_covaried.txt"
input="age+sex+meanFD+composite+update+switch_allpermuted.mdmr/zstats_cshresidualvariance.nii"
cluster -i ${input} -t ${t} \
-p ${i} --dlh=0.212883 \
--volume=20169 --minclustersize \
-o ${output} > ${filename};
echo "$t$i"
echo ${output}
done;
done
#done
##OLD##
##DLH VALUES NOT CORRECTED FOR EACH Z-STAT IMAGE

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
