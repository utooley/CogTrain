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
