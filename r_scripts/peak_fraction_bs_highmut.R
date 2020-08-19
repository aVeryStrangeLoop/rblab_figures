library(ggplot2)
library(viridis)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/peak_fractions_bs.csv")

data$res_f = factor(data$res, levels=c('8k','10k','100k','1000k'))
data$pop_f = factor(data$pop, levels=c(100,200,500))

data_l<- data[data$mut=="h",]
data_l_agg <- aggregate(x=data_l["p3"],by=list(res=data_l$res_f,pop=data_l$pop_f),FUN=function(x) c(mn = mean(x), stdev = sd(x)))
data_l_agg <- do.call(data.frame,data_l_agg)
data_final <- data_l_agg[data_l_agg$res!="8k",]
colnames(data_final)[3] <- "mn"
colnames(data_final)[4] <- "stdev"

p <- ggplot(data_final,aes(x=res,y=mn,group=pop,color=pop)) +
  geom_point(position=position_dodge(.1)) + geom_line(position=position_dodge(.1))+
  geom_errorbar(aes(ymin=mn-stdev,ymax=mn+stdev),width=.3,
                position=position_dodge(.1)) + theme_minimal() +
  theme(axis.text.x = element_text(angle =45),legend.position = "None") + ylim(0,0.4)
p  + xlab("Resource abundance") + ylab("Fraction of genotypes") + labs(color="Carrying capacity")

