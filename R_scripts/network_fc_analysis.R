library(dplyr)
library(psych)
#create dataframes
setwd("/Users/utooley/Documents/Kable_Lab/CogTrain/fc_map_Yeo_networks/")
setwd("/Users/josephkable/Desktop/Ursula/Kable_Lab/CogTrain/fc_map_Yeo_networks/")
within_network <- read.csv("mean_within_network_connectivity.csv")
between_network <- read.csv("mean_between_network_connectivity.csv")
within_network <- within_network[-c(140:141),]
between_network <- between_network[-c(140:142),]

cog <- read.csv("/Users/utooley/Documents/Kable_Lab/CogTrain/CogTrain/regressors_agesexFD_cogupdateswitch_111016.csv")

within_network <- data.frame(c(within_network,cog))
between_network <- data.frame(c(between_network,cog))

#SEE IF CORRELATE
##within network correlations
matrix <- within_network %>% select(., -sex)
correlation <- cor(matrix, method="pearson")
View(round(correlation,2))

#between network correlations
matrix <- between_network %>% select(., -sex)
correlation <- cor(matrix, method="pearson")
View(round(correlation,2))

cor.test(within_network$DA, within_network$composite)
cor.test(within_network$VA, within_network$composite)
cor.test(within_network$FP, within_network$composite)
cor.test(within_network$DMN, within_network$composite)

#between network
cor.test(between_network$SM.DA, between_network$composite)
cor.test(between_network$SM.VA, between_network$composite)
cor.test(between_network$SM.FP, between_network$composite)
cor.test(between_network$SM.DMN, between_network$composite)
cor.test(between_network$DA.VA, between_network$composite)
cor.test(between_network$DA.FP, between_network$composite)
cor.test(between_network$DA.DMN, between_network$composite)
cor.test(between_network$VA.FP, between_network$composite)
cor.test(between_network$VA.DMN, between_network$composite)
cor.test(between_network$FP.DMN, between_network$composite)

##use linear model to control for covariates
##between network
model <- lm(composite~DA.DMN+age+meanFD+sex+cshresidualvariance+vnbresidualvariance, data=between_network)
summary(model)

model <- lm(composite~DA.DMN+age+sex+meanFD, data=between_network)
summary(model)

model <- lm(composite~SM.VA+age+meanFD+sex+cshresidualvariance+vnbresidualvariance, data=between_network)
summary(model)

model <- lm(composite~SM.VA+age+sex+meanFD, data=between_network)
summary(model)

model <- lm(composite~VA.DMN+age+meanFD+sex+cshresidualvariance+vnbresidualvariance, data=between_network)
summary(model)

model <- lm(composite~VA.DMN+age+sex+meanFD, data=between_network)
summary(model)

model <- lm(composite~FP.DMN+age+meanFD+sex+cshresidualvariance+vnbresidualvariance, data=between_network)
summary(model)

model <- lm(composite~FP.DMN+age+sex+meanFD, data=between_network)
summary(model)

model <- lm(composite~VA.FP+age+meanFD+sex+cshresidualvariance+vnbresidualvariance, data=between_network)
summary(model)

model <- lm(composite~VA.FP+age+sex+meanFD, data=between_network)
summary(model)

model <- lm(composite~DA.FP+age+meanFD+sex+cshresidualvariance+vnbresidualvariance, data=between_network)
summary(model)

model <- lm(composite~DA.FP+age+sex+meanFD, data=between_network)
summary(model)

#may be missing some here

model <- lm(composite~DA+age+sex+meanFD, within_network)
summary(model)

model <- lm(composite~VA+age+sex+meanFD, within_network)
summary(model)

model <- lm(composite~FP+age+sex+meanFD, within_network)
summary(model)

model <- lm(composite~DMN+age+sex+meanFD, within_network)
summary(model)


