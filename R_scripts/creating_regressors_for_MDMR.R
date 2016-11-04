setwd("/Users/utooley/Documents/Kable_Lab/CogTrain/")
setwd("/Users/josephkable/Desktop/Ursula/Kable_Lab/CogTrain/")
library(dplyr)
headmotion <- read.csv("CTn166_rsfMRI_HeadMotion_clean.csv", sep = ",", header = TRUE)
regressors <- read.csv("DMP_pretx_tasks_commonswitchonly_101116.csv", sep=",", header=TRUE)

##add in age and sex here, keep only those we're interested in
setwd("/Users/josephkable/Desktop/Ursula/Kable_Lab/CogTrain/Non-Active")
demo <-  read.csv("DMP_pretx_demo_tasks_withnewvars_12.15.15.csv", sep = ",", header = TRUE,)
demo <- select(demo, DMP_ID, age, sex)

##match those in headmotion to those in regressors (which have excluded the cognitive outliers)
headmotion <- rename(headmotion, DMP_ID=Subject.ID )
all <- left_join(regressors, headmotion, by="DMP_ID")
all <- left_join(all, demo, by= "DMP_ID")

#now take out outliers from movement
outliers <- c("DMP0010", "DMP0216", 
              "DMP0381", "DMP0442", "DMP0521", "DMP0760", "DMP0777",
              "DMP0782", "DMP0909", "DMP0912", "DMP0919", "DMP0922",
              "DMP0952", "DMP1006", "DMP1070", "DMP1248")
for (i in 1:length(outliers)){
  all <- all[!grepl(outliers[i], all$DMP_ID),]}

colnames(all)
all <- all[,c(1:5, 12:14)]
##write to a file

write.csv(all, file="/Users/josephkable/Desktop/Ursula/Kable_Lab/CogTrain/demo_and_EF_MDMR_regressors_110416.csv")
