library(ggplot2)
library(viridis)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/h3toh1_cl_hetero.csv")
names(data)
data$upd <- as.factor(data$upd)

library(ggpubr)
my_comparisons <- list(c("WT","0"),c("0","5000"))

levels(data$upd) <- c("WT",0,1000,2000,3000,4000,5000)
p <- ggplot(data,aes(x=upd,y=entropy)) + geom_boxplot() + theme_minimal()
p + xlab("Update") + ylab("Population heterogeneity")+ ylim(50,300)+
  ggtitle("H3 genotypes with H1 copy-loop")+
  theme(plot.title = element_text(hjust = 0.5)) +
  stat_compare_means(method = "wilcox.test",comparisons = my_comparisons,label = "p.signif", tip.length=0.05,label.y=c(275,285))



