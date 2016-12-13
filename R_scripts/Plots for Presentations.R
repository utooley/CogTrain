library(ggplot2)
library(RColorBrewer)
##education
#plot <- ggplot(data=prebeh, aes(x=edu, fill=edu))+geom_bar(stat="identity")+scale_fill_brewer()
#plot <- plot+theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
#plot+scale_fill_brewer(palette="PuBu")

plot <- qplot(prebeh$edu, xlab="Education Levels", ,geom="bar", fill=prebeh$edu)
plot <- plot+theme_classic()+theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(legend.position="none")
plot+scale_fill_brewer(palette="Set2")

##income
+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
       panel.background = element_blank(), axis.line = element_line(colour = "white"))

plot <- qplot(prebeh$income, xlab="Income Levels", ,geom="bar", fill=prebeh$income)
plot <- plot+theme_classic()+theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(legend.position="none")
plot+scale_fill_brewer(palette="Set2")

qplot(income, data=prebeh, geom="bar", fill=race)+scale_fill_brewer(palette="Spectral")+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                              panel.background = element_blank(), axis.line = element_line(colour = "white"))


##FUNCTIONAL CONNECTIVITY##
##make plots for within network
#load data
setwd("/Users/utooley/Documents/Kable_Lab/CogTrain/fc_map_Yeo_networks/")
setwd("/Users/josephkable/Desktop/Ursula/Kable_Lab/CogTrain/fc_map_Yeo_networks/")
within_network <- read.csv("mean_within_network_connectivity.csv")
between_network <- read.csv("mean_between_network_connectivity.csv")
within_network <- within_network[-c(140:141),]
between_network <- between_network[-c(140:142),]

#summarize
summary <- describe(within_network)
#plot
within.network <- barplot(colMeans(within_network), main="Average Within Network Connectivity", 
                          ylab = "Mean Connectivity", xlab = "Network", ylim = c(0, 0.6), col=brewer.pal(8, "Set3"))
#add error bars
arrows(x0=within.network,y0=colMeans(within_network)+summary$se,y1=colMeans(within_network)-summary$se,angle=90,code=3,length=0.1)

##make plots for between network connectivity##
summary <- describe(between_network)
#plot
between.network <- barplot(colMeans(between_network), main="Average Between Network Connectivity", 
                          ylab = "Mean Connectivity", las= 2, ylim= c(-0.2, 0.4), col=brewer.pal(8, "Set3"))
#add error bars
arrows(x0=between.network,y0=colMeans(between_network)+summary$se,y1=colMeans(between_network)-summary$se,angle=90,code=3,length=0.1)



