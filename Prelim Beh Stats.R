library(psych)
library(dplyr)
#import behavioral data

getwd()
prebeh <- read.csv("DMP_pretx_demo_tasks_full_12.15.15.csv", sep = ",", header = TRUE)
prebeh
describe(prebeh)
glimpse(prebeh)
str(prebeh)
summary(prebeh)
colnames(prebeh)

#keep only ones of interest
columns=c("DMP_ID", "sex", "race", "race_oth", "ethnicity",
         "edu", "employ", "income","cog_outlier_pretx", "marital", "shipley",
         "treatment", "bt_ach_tot", "bt_adh_pc", "bmi", 
         "bmi25", "cpt_tp_ct_pretx",  "cpt_tp_mn_pretx",
         "csh_cost_mn_pretx", "csh_cost_md_pretx", "sst_ssrt_pretx",
         "str_stroop_mn_pretx", "str_stroop_md_pretx", "vnb_tp_ct_0_pretx", 
         "vnb_tp_ct_1_pretx", "vnb_tp_ct_2_pretx", "vnb_tp_ct_3_pretx", "vnb_tp_md_0_pretx",
         "vnb_tp_md_1_pretx", "vnb_tp_md_2_pretx", "vnb_tp_md_3_pretx")
prebeh <- prebeh %>% select(one_of(columns))

#remove cognitive outliers
prebeh <- prebeh %>% filter(cog_outlier_pretx==0)
#relevel income so it's in the right order
prebeh$income <- factor(prebeh$income, levels=c("<$20,000", "$20,000-35,000", "$35,001-50,000", "$50,001-75,000", ">$75,000"))
summary(prebeh)
plot(prebeh$income)

#convert factor variables to numeric
hist(prebeh$income, breaks = 6)
#look at whether IQ varies by income, have to transform to numeric first
prebeh$income <- as.numeric(prebeh$income)
test <- lm(sst_ssrt_pretx~income, prebeh)
summary(test)

#look at all variables by income
t <- prebeh %>% group_by(income) %>% summarise_each(funs(mean))
View(t)

#correlation
cor(prebeh$income, prebeh$shipley)
