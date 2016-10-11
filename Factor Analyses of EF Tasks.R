library(psych)
library(dplyr)
#import behavioral data

getwd()
prebeh <- read.csv("DMP_pretx_demo_tasks_allnewvars_dprimes_100616.csv"", sep = ",", header = TRUE)
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
efcols3=c("cpt_tp_ct_pretx", 
          "csh_cost_md_pretx", "sst_ssrt_pretx",
          "str_stroop_md_pretx", "vnb_tp_md_slope")
efcolsall=c("cpt_tp_ct_pretx", "cpt_dprime_pretx", 
            "csh_cost_md_pretx", "sst_ssrt_pretx",
            "str_stroop_md_pretx", "vnb_tp_md_slope", "vnb_tp_ct_all_pretx")
eftasks <- select(prebeh, one_of(columns))
eftaskscor <- cor(eftasks)
cor.test(eftasks$sst_ssrt_pretx, eftasks$str_stroop_md_pretx)
View(round(eftaskscor, 2))

#determining number of components to extract
library(nFactors)
ev <- eigen(cor(eftasks)) # get eigenvalues
ap <- parallel(subject=nrow(eftasks),var=ncol(eftasks),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)
summary(nS)


#EFA with maximum likelihood factor analysis
fit <- factanal(eftasks, 2, rotation ="varimax")
print(fit, digits=2, cutoff=.3, sort=TRUE)
load <- fit$loadings[,1:2] 
plot(load,type="n") # set up plot 
text(load,labels=names(eftasks),cex=.7) # add variable names

#EFA using minimum residual (can also change to do principal axes)
fit <- fa(eftasks, nfactors=2, rotate = "oblimin", fm = "minres")
print(fit, digits = 2)

#Varimax rotated PCA or using oblimin
library(GPArotation)
fit <- principal(eftasks, nfactors=3, rotate="varimax")
fit
fit <- principal(eftasks, nfactors=2, rotate="oblimin")
fit


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

##ACCORDING TO FIELDS
cortest.bartlett(eftasks)
#Bartlett's test significant, good
KMO(eftasks)
#CSH is worrisome, KMO value below 0.5 sometimes
det(eftaskscor)
#using PCA
model <- principal(eftasks, nfactors=5, rotate="none")
model
#scree plot
plot(model$values, type="b")
#by Kaiser's criterion decide how many factors to extract
model1 <- principal(eftasks, nfactors=3, rotate= "none")
model1
model2 <- principal(eftasks, nfactors=3, rotate="oblimin")
model2
#print readable output
print.psych(model2, cut=0.3, sort=TRUE)
