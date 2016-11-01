library(psych)
library(dplyr)
#import behavioral data

getwd()
setwd("/Users/utooley/Documents/Kable_Lab/CogTrain/CogTrain/Non-Active")
prebeh <- read.csv("DMP_pretx_demo_tasks_allnewvars_dprimes_100616.csv", sep = ",", header = TRUE)
describe(prebeh)
glimpse(prebeh)
str(prebeh)
summary(prebeh)
colnames(prebeh)

#keep only ones of interest
columns=c("DMP_ID", "sex", "age", "race", "race_oth", "ethnicity",
         "edu", "employ", "income","cog_outlier_pretx", "marital", "shipley",
         "treatment", "bt_ach_tot", "bt_adh_pc", "bmi", 
         "bmi25", "cpt_tp_ct_pretx",  "cpt_dprime_pretx", 
         "csh_cost_md_pretx", "sst_ssrt_pretx",
         "str_stroop_md_pretx", "vnb_tp_ct_all_pretx",
         "vnb_tp_ct_slope", "vnb_tp_md_slope", "vnb_tp_ct_3_pretx")
prebeh <- prebeh %>% select(one_of(columns))

#remove cognitive outliers
prebeh <- prebeh %>% filter(cog_outlier_pretx==0)
#relevel income, education so they're in the right order
prebeh$income <- factor(prebeh$income, levels=c("<$20,000", "$20,000-35,000", "$35,001-50,000", "$50,001-75,000", ">$75,000"))
prebeh$edu <- factor(prebeh$edu, levels=c("Grade school", "Some high school", "HS grad or GED", 
                                             "Some coll or technical school", "College grad or beyond"))
describe(prebeh)
plot(prebeh$income)
eftasks<-cor(prebeh)

#convert factor variables to numeric
hist(prebeh$income, breaks = 6)
#look at whether IQ varies by income, have to transform to numeric first
prebeh$income <- as.numeric(prebeh$income)
test <- lm(sst_ssrt_pretx~income, prebeh)
summary(test)


#look at all variables by income
t <- prebeh %>% group_by(income) %>% summarise_each(funs(mean))
View(t)
#look at all variables by incomebin
t <- prebeh %>% group_by(incomebin) %>% summarise_each(funs(mean))
View(t)
#look at correlation table (convert income and edu to numeric first)
prebeh$income <- as.numeric(prebeh$income)
prebeh$edu <- as.numeric(prebeh$edu)
table(prebeh$income)
cor(prebeh[sapply(prebeh, is.numeric)], use="complete.obs")

#recode income to above/below 20,000
prebeh$incomebin <- ifelse(prebeh$income == "<$20,000",0, 1)
#look at race and income crosstabs
table <- table(prebeh$income, prebeh$race)
write.csv(table, "raceandincome.csv")
prop.table(table,1)
chisq.test(table)
fisher.test(table)
#look at crosstabs by education
table <- table(prebeh$edu, prebeh$race)
table

#correlation
cor(prebeh$income, prebeh$shipley)
