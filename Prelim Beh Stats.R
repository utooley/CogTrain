library(psych)
#import behavioral data

getwd()
prebeh <- read.csv("DMP_pretx_demo_tasks_full_12.15.15.csv", sep = ",", header = TRUE)
prebeh
describe(prebeh)
