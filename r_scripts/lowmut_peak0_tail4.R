library(ggplot2)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/lowmut_samples_100/tail_replace/peak0_tail4.csv")
data_sub <- data[data$repl==0,] # Replicates are very similar
data_sub$update <- as.factor(data_sub$update) 

non_viable <- data_sub[data_sub$update==0 & data_sub$scf<1,]
length(non_viable$init_genome)

data_sub_sanit <- data_sub[!data_sub$init_genome %in%  non_viable$init_genome,] 
levels(data_sub_sanit$update) <- c("WT",0,1000,2000,3000,4000,5000)

## Plot fitness
p <- ggplot(data_sub_sanit,aes(x="",y=scf))  + facet_grid(.~update,switch="both") +
  geom_violin() + geom_boxplot(width=0.1)+
  theme_minimal() +
  xlab("Update") + ylab("Fitness")
p

p2 <- ggplot(data_sub_sanit,aes(x="",y=merit))  + facet_grid(.~update,switch="both") +
  geom_violin() + geom_boxplot(width=0.2)+
  theme_minimal() +
  xlab("Update") + ylab("Merit") + coord_cartesian(ylim=c(110,120))
p2

