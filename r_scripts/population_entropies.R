library(ggplot2)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/populations_classified.csv")
data$peak_by_dominant <- as.factor(data$peak_by_dominant)
data
p <- ggplot(data[data$peak_by_dominant!=-1,],aes(x=peak_by_dominant,y=entropy))+ geom_boxplot() 
p + theme_minimal() + facet_grid(pop~res_ab) +xlab("Peak") + ylab("Population genomic entropy")
