##Create list of ROIs for functional connectivity

setwd("/Users/utooley/Documents/Kable_Lab/CogTrain/CWAS/network_connectivity_wi_hoon_files/Yeo_ROIs/Yeo2011_resNN4mm/Yeo2011_resNN4mm_Volume_Temp")
filez<-list.files(path=".", recursive = TRUE)
head(filez)
tail(filez)
filea <- sapply(filez, FUN=function(eachPath)
{paste("/Users/utooley/Documents/Kable_Lab/CogTrain/CWAS/network_connectivity_wi_hoon_files/Yeo_ROIs/Yeo2011_resNN4mm/Yeo2011_resNN4mm_Volume_Temp", 
       eachPath, sep="", collapse=NULL)})


write(filea, file="/Users/utooley/Documents/Kable_Lab/CogTrain/CWAS/network_connectivity_wi_hoon_files/list_of_ROIs_for_FC.txt")


##by hand copy over folders from func_pcc_ARCWSF
##delete all the full sized files
newdir="/Users/utooley/Documents/Kable_Lab/CogTrain/image_data/rfunc_ppc_ARCWSF/"
setwd(newdir)
junk <- list.files(path=".", pattern="^Filtered_4DVolume.nii$", recursive = TRUE)
junk
file.remove(junk)
