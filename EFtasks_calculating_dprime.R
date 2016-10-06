library(psych)
library(dplyr)
#import behavioral data
prebeh <- read.csv("DMP_pretx_demo_tasks_withnewvars_12.15.15.csv", sep = ",", header = TRUE)
colnames(prebeh)
#filter out only n-back and cpt columns
vnb <- prebeh %>% select(contains("vnb"))
colnames(vnb)
cpt <- prebeh %>% select(contains("cpt"))
colnames(cpt)

#make vnb total number of trials for each participant
vnb <- mutate(vnb,vnb_tot_trials=vnb_fp_ct_all_pretx+ vnb_tp_ct_all_pretx + 
         vnb_fn_ct_0_pretx+ vnb_fn_ct_1_pretx+ vnb_fn_ct_2_pretx + vnb_fn_ct_3_pretx)

#make cpt total number of trials for each participant
cpt <- mutate(cpt, cpt_total_trials=cpt_fp_ct_pretx+cpt_fn_ct_pretx+cpt_tp_ct_pretx)
vnb$vnb_tot_trials
cpt$cpt_total_trials
#see max min 
describe(cpt$cpt_total_trials)
describe(vnb$vnb_tot_trials)

#

#write new data file for future use
write(prebeh, 
      file= "DMP_pretx_demo_tasks_allnewvars_dprimes_100616.csv", sep = ",")


