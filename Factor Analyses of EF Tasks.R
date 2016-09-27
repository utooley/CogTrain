library(psych)
library(dplyr)
#import behavioral data

getwd()
prebeh <- read.csv("DMP_pretx_demo_tasks_withnewvars_12.15.15.csv", sep = ",", header = TRUE)
describe(prebeh)
glimpse(prebeh)
str(prebeh)
summary(prebeh)
colnames(prebeh)

#remove cognitive outliers
prebeh <- prebeh %>% filter(cog_outlier_pretx==0)

#set up variables to be all in positive direction
#reverse load-dependent RT slope, switch cost, SSRT and stroop effect
prebeh$vnb_tp_md_slope <- -(prebeh$vnb_tp_md_slope)
#prebeh$cpt_dprime_pretx <- abs(prebeh$cpt_dprime_pretx)
prebeh$sst_ssrt_pretx <- -(prebeh$sst_ssrt_pretx)
prebeh$str_stroop_md_pretx <- -(prebeh$str_stroop_md_pretx)
prebeh$csh_cost_md_pretx <- -(prebeh$csh_cost_md_pretx)

#keep only EF columns of interest ones of interest
efcols1=c("cpt_dprime_pretx", 
          "csh_cost_md_pretx", "sst_ssrt_pretx",
          "str_stroop_md_pretx",
           "vnb_tp_md_slope")
efcols2=c("cpt_tp_ct_pretx", 
          "csh_cost_md_pretx", "sst_ssrt_pretx",
          "str_stroop_md_pretx", "vnb_tp_ct_all_pretx")
eftasks <- select(prebeh, one_of(efcols1))
eftaskscor <- cor(eftasks)
View(eftaskscov)

#determining number of components to extract
library(nFactors)
ev <- eigen(cor(eftasks)) # get eigenvalues
ap <- parallel(subject=nrow(eftasks),var=ncol(eftasks),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)
summary(nS)

#EFA with maximum likelihood factor analysis
fit <- factanal(eftasks, 2, rotation = "varimax")
print(fit, digits=2, cutoff=.3, sort=TRUE)
load <- fit$loadings[,1:2] 
plot(load,type="n") # set up plot 
text(load,labels=names(eftasks),cex=.7) # add variable names

#CFA according to Miyake's tasks loading model (but only have one domain in which more than 1 task
#can't really do)
library(lavaan)

# specify the model
miyake.model <- ' inhibit  =~ str_stroop_md_pretx + sst_ssrt_pretx      
update =~ vnb_tp_md_slope
shift   =~ csh_cost_md_pretx '

# fit the model
fit <- cfa(miyake.model, data=eftasks)

# display summary output
summary(fit, fit.measures=TRUE)

#PCA using oblimin



