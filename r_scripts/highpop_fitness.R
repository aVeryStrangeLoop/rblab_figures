library(ggplot2)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/highpop_fitnesses.csv")
names(data)
p <- ggplot(data,aes(x=scf)) + geom_density()
p + facet_grid(repl~pop,labeller = label_both)  + xlab("Fitness") + ylab("Density") +
  theme_minimal()
