library(connectir)

connectir_subdist.R
-i functional_images_list.txt \
--automask1 \
--brainmask1 GreyMask_v2_4mm.nii \
--bg single_subj_T1.nii \
--memlimit 20 -c 3 -t 4 \
/Users/utooley/Documents/Kable Lab/CogTrain/image_data/test

setwd("/Users/utooley/Documents/Kable Lab/CogTrain/CogTrain/R_scripts/connectir-master/inst/scripts/")

#brainmask1:
#here use Wager mask 4rgray_matter_mask_binary
#standard brain here
#here use standard brain from SPM, /spm12/canonical/single_subj_T1.nii

#paste this in the terminal and it looks like it's starting to work!
#however, haven't gotten anywhere yet
#stuck on GreyMask_v2_4mm.nii being a 3D image and not 4 D

Rscript connectir_subdist.R -i test/functional_images_list.txt --automask1 --brainmask1 test/GreyMask_v2_4mm.nii --bg test/single_subj_T1.nii --memlimit 20 /Users/utooley/Documents/tes1t

#test whether voxels in mask are true somewhere
table(inlist1$mask)["TRUE"]
#some are!


##Trying to put in command line arguments and then run in R
infuncs1="test/functional_images_list.txt"
automask1=TRUE
brainmask1="test/GreyMask_v2_4mm.nii"
bg= "test/single_subj_T1.nii"
memlimit = c(20)
outdir ="/Users/utooley/Documents/tes1t"
source("connectir_subdist_worker.R")
