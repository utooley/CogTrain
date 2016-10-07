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

#Total target trials for VNB=60, Non-target trials=140
vnb$vnb_hit=(vnb$vnb_tp_ct_all_pretx)/60
vnb$vnb_fa=(vnb$vnb_fp_ct_all_pretx)/140

#replace max and min values (0's and 1's) with 1-1/2n for hits or 1/2n for fa according to Haatveit et al 2009
#n=num of targets/non-targets
nh=1-1/(2*60)
nfa=1/(2*140)
vnb$vnb_hit <- replace(vnb$vnb_hit, vnb$vnb_hit==1, nh)
vnb$vnb_fa <- replace(vnb$vnb_fa, vnb$vnb_fa==0, nfa)
vnb$
#look for this percentage on the Z distribution
vnb$vnb_hit_z=qnorm(vnb$vnb_hit)
vnb$vnb_fa_z=qnorm(vnb$vnb_fa)

vnb$vnb_fa_z
vnb$vnb_hit_z
#create a d-prime measure
vnb$vnb_ct_dprime=vnb$vnb_hit_z-vnb$vnb_fa_z
describe(vnb$vnb_ct_dprime)


# Continous Performance (CPT) ---------------------------------------------

#Total target trials for VNB=60, Non-target trials=140
vnb$vnb_hit=(vnb$vnb_tp_ct_all_pretx)/60
vnb$vnb_fa=(vnb$vnb_fp_ct_all_pretx)/140

#replace max and min values (0's and 1's) with 1-1/2n for hits or 1/2n for fa according to Haatveit et al 2009
#n=num of targets/non-targets
nh=1-1/(2*60)
nfa=1/(2*140)
vnb$vnb_hit <- replace(vnb$vnb_hit, vnb$vnb_hit==1, nh)
vnb$vnb_fa <- replace(vnb$vnb_fa, vnb$vnb_fa==0, nfa)
vnb$

#look for this percentage on the Z distribution
vnb$vnb_hit_z=qnorm(vnb$vnb_hit)
vnb$vnb_fa_z=qnorm(vnb$vnb_fa)

vnb$vnb_fa_z
vnb$vnb_hit_z
#create a d-prime measure
vnb$vnb_ct_dprime=vnb$vnb_hit_z-vnb$vnb_fa_z
describe(vnb$vnb_ct_dprime)

#write new data file for future use
write(prebeh, 
      file= "DMP_pretx_demo_tasks_allnewvars_dprimes_100616.csv", sep = ",")


