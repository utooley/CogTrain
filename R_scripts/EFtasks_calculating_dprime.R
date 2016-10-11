library(psych)
library(dplyr)
#import behavioral data
setwd("/Users/josephkable/Desktop/Ursula/Kable Lab/CogTrain/")
prebeh <- read.csv("DMP_pretx_demo_tasks_withnewvars_12.15.15.csv", sep = ",", header = TRUE)
colnames(prebeh)
#filter out only n-back and cpt columns
vnb <- prebeh %>% select(contains("vnb"))
colnames(vnb)
cpt <- prebeh %>% select(contains("cpt"))
colnames(cpt)

# Visual N-Back -----------------------------------------------------------

#Total target trials for VNB=60, Non-target trials=180 per Mary Falcone
vnb$vnb_hit=(vnb$vnb_tp_ct_all_pretx)/60
vnb$vnb_fa=(vnb$vnb_fp_ct_all_pretx)/180

#replace max and min values (0's and 1's) with 1-1/2n for hits or 1/2n for fa according to Haatveit et al 2009
#n=num of targets/non-targets
nh=1-1/(2*60)
nfa=1/(2*180)
vnb$vnb_hit <- replace(vnb$vnb_hit, vnb$vnb_hit==1, nh)
vnb$vnb_fa <- replace(vnb$vnb_fa, vnb$vnb_fa==0, nfa)
describe(vnb$vnb_fa)
describe(vnb$vnb_hit)

#look for this percentage on the Z distribution
vnb$vnb_hit_z=qnorm(vnb$vnb_hit)
vnb$vnb_fa_z=qnorm(vnb$vnb_fa)

vnb$vnb_fa_z
vnb$vnb_hit_z
#create a d-prime measure
vnb$vnb_dprime_pretx=vnb$vnb_hit_z-vnb$vnb_fa_z
describe(vnb$vnb_dprime_pretx)

#calculate the maximum and minimum possible d', which is +_5.167
vnbhitmax=qnorm(nh)
vnbfamin=qnorm(nfa)
vnb_ct_dprime_max=vnbhitmax-vnbfamin
vnb_ct_dprime_max

# Continous Performance (CPT) ---------------------------------------------

#Total target trials for CPT=120, Non-target trials=240
cpt$cpt_hit=(cpt$cpt_tp_ct_pretx)/120
cpt$cpt_fa=(cpt$cpt_fp_ct_pretx)/240

#replace max and min values (0's and 1's) with 1-1/2n for hits or 1/2n for fa according to Haatveit et al 2009
#n=num of targets/non-targets
nh=1-1/(2*120)
nfa=1/(2*240)
cpt$cpt_hit <- replace(cpt$cpt_hit, cpt$cpt_hit==1, nh)
cpt$cpt_fa <- replace(cpt$cpt_fa, cpt$cpt_fa==0, nfa)
describe(cpt$cpt_hit)

#look for this percentage on the Z distribution
cpt$cpt_hit_z=qnorm(cpt$cpt_hit)
cpt$cpt_fa_z=qnorm(cpt$cpt_fa)

#calculate the maximum and minimum possible d', which is +-5.503
cpthitmax=qnorm(nh)
cptfamin=qnorm(nfa)
cpt_ct_dprime_max=cpthitmax-cptfamin
cpt_ct_dprime_max

cpt$cpt_fa_z
cpt$cpt_hit_z
#create a d-prime measure
cpt$cpt_dprime_pretx=cpt$cpt_hit_z-cpt$cpt_fa_z
describe(cpt$cpt_ct_dprime)

prebeh <- select(prebeh, -vnb_dprime_pretx)
prebeh <- select(prebeh, -cpt_dprime_pretx)
prebeh <- data.frame(prebeh,vnb$vnb_dprime_pretx, cpt$cpt_dprime_pretx)
prebeh <- rename(prebeh, vnb_dprime_pretx=vnb.vnb_dprime_pretx)
prebeh <- rename(prebeh, cpt_dprime_pretx=cpt.cpt_dprime_pretx)
#write new data file for future use, ouput blank cells instead of NA
write.csv(prebeh, 
      file= "DMP_pretx_demo_tasks_allnewvars_dprimes_100616.csv", na="")


