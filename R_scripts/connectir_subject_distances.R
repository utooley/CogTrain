

connectir_subdist.R
-i functional_path_list.txt \
--automask1 \
--brainmask1 standard_grey_matter.nii.gz \
#here use Wager mask 4rgray_matter_mask_binary
--bg standard_brain_4mm.nii.gz \
#here use standard brain from SPM, /spm12/canonical/single_subj_T1.nii
--memlimit 20 -c 3 -t 4 \
subject_distances_outdir