library(psych)
library(dplyr)
library(lattice)
#import behavioral data

getwd()
setwd("/Users/utooley/Documents/Kable_Lab/CogTrain/CogTrain/Non-Active/")
prebeh <- read.csv("DMP_pretx_demo_tasks_allnewvars_dprimes_100616.csv", sep = ",", header = TRUE)
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
            "str_stroop_md_pretx", "vnb_dprime_pretx", "vnb_tp_ct_all_pretx")
efcolsdprimes=c("DMP_ID","cpt_dprime_pretx", "csh_cost_md_pretx", "sst_ssrt_pretx",
                "str_stroop_md_pretx", "vnb_dprime_pretx")
eftasks <- select(prebeh, one_of(efcolsdprimes))
eftaskscor <- cor(eftasks)

#look at whether dprimes significantly correlate with other variables (not CSH)
cor.test(eftasks$sst_ssrt_pretx, eftasks$vnb_dprime_pretx)
cor.test(eftasks$str_stroop_md_pretx, eftasks$vnb_dprime_pretx)
cor.test(eftasks$sst_ssrt_pretx, eftasks$cpt_dprime_pretx)
cor.test(eftasks$str_stroop_md_pretx, eftasks$cpt_dprime_pretx)
View(round(eftaskscor, 2))
write.csv(round(eftaskscor,2), file="EFtaskcorrelations.csv")


# Factor Analysis ---------------------------------------------------------

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
model1 <- principal(eftasks, nfactors=2, rotate= "none")
model1
model2 <- principal(eftasks, nfactors=2, rotate="oblimin")
model2
#print readable output
print.psych(model2, cut=0.3, sort=TRUE)


# Create a Composite EF Score and Residual CSH Switching Instead o --------

#z-score each EF task
efzscores <- eftasks %>%  mutate_each(., funs(zscore=scale(.)), -DMP_ID) 
head(efzscores)

#take average of the z-scores for 5 tasks
efzscores$composite <- rowMeans(select(efzscores, contains("zscore")))
describe(efzscores$composite)

#Shapiro-Wilks test for normality
shapiro.test(efzscores$composite)

#get residual variance in CSH median cost after regressing out this composite
switchmodel <- lm(csh_cost_md_pretx_zscore~composite, data=efzscores)
summary(switchmodel)
efzscores$csh_residual_variance <- resid(switchmodel)

#plot to check that residuals were still in the right order as the data frame
plot(predict(switchmodel)+resid(switchmodel)~csh_cost_md_pretx_zscore, data=efzscores)

describe(efzscores$csh_residual_variance)

#Shapiro-Wilks test for normality
shapiro.test(efzscores$csh_residual_variance)

#get residual variance in VNB-dprime (updating) after regressing out this composite
switchmodel1 <- lm(vnb_dprime_pretx_zscore~composite, data=efzscores)
summary(switchmodel1)
efzscores$vnb_residual_variance <- resid(switchmodel1)

describe(efzscores$vnb_residual_variance)

#Shapiro-Wilks test for normality
shapiro.test(efzscores$vnb_residual_variance)

ofinterest <- data.frame(select(efzscores, DMP_ID, composite, csh_residual_variance, vnb_residual_variance))

#Write these back to a data file to use
setwd("/Users/utooley/Documents/Kable Lab/Data/CogTrain")
write.csv(efzscores, "DMP_pretx_tasks_EFzscores_101116.csv", na="")
write.csv(ofinterest, "DMP_pretx_tasks_commonswitchonly_101116.csv", na="")

#look at correlations between csh residuals and other EF tasks
efcor <- cor(select(efzscores, -DMP_ID), use ="pairwise.complete.obs")
View(round(efcor,2))
