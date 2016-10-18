connectir_subdist.R
-i functional_path_list.txt \
--automask1 \
--brainmask1 standard_grey_matter.nii.gz \
--bg standard_brain_4mm.nii.gz \
--memlimit 20 -c 3 -t 4 \
subject_distances_outdir