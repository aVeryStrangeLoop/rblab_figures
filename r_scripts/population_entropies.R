library(ggplot2)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/populations_classified.csv")
data$peak_by_dominant <- as.factor(data$peak_by_dominant)
data

library(ggpubr)
my_comparisons <- list(c("0","1"),c("1","2"),c("1","3"))

p <- ggplot(data[data$peak_by_dominant!=-1,],aes(x=peak_by_dominant,y=entropy))+ geom_boxplot() 
p + theme_minimal() +xlab("Peak") + ylab("Population genomic entropy") + ylim(NA,375) +
  stat_compare_means(method = "wilcox.test",comparisons = my_comparisons,label = "p.signif", tip.length=0.01, label.y = c(300,325,350))

