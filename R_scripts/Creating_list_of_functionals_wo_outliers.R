##Create functional images text file for input to connectir_subdist.R script

setwd("/Users/utooley/Documents/Kable_Lab/CogTrain/image_data/func_ppc_ARCWSF")
filez<-list.files(path=".", pattern="DMP")
head(filez)
filea <- sapply(filez, FUN=function(eachPath)
{paste("/Users/utooley/Documents/Kable_Lab/CogTrain/image_data/func_ppc_ARCWSF/", 
         eachPath, sep="", collapse=NULL)})
filesb <- paste(filea, "/rFiltered_4DVolume.nii", sep="")

##take out outliers from movement
outliers <- c("DMP0010", "DMP0216", 
              "DMP0381", "DMP0442", "DMP0521", "DMP0760", "DMP0777",
              "DMP0782", "DMP0909", "DMP0912", "DMP0919", "DMP0922",
              "DMP0952", "DMP1006", "DMP1070", "DMP1248")
for (i in 1:length(outliers)){
  filesb <- filesb[!grepl(outliers[i], filesb)]}

##take out cognitive outliers
#pull from behavioral file
library(dplyr)
prebeh <- read.csv("/Users/utooley/Documents/Kable_Lab/CogTrain/CogTrain/Non-Active/DMP_pretx_demo_tasks_allnewvars_dprimes_100616.csv", sep = ",", header = TRUE)
outliersc <- prebeh %>% filter(cog_outlier_pretx==1)
outliersc <- as.character(outliersc$DMP_ID)
length(outliersc)
outliersc <- as.character(outliersc)

#take out of list
for (i in 1:length(outliersc)){
  filesb <- filesb[!grepl(outliers[i], filesb)]}
  
write(filesb, file="/Users/utooley/Documents/Kable_Lab/CogTrain/CWAS/functional_images_list_wo_outliers.txt")
