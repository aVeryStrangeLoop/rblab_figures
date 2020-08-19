library(ggplot2)
library(viridis)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/lowmut_samples_100/genomes_maxima4.csv")
library(boot)
data
# Performing 1500 replications with boot 
output <- boot(data=data, statistic=mean, 
               R=1500, formula=)
# Plotting the output
output 
plot(output)
# Obtaining a confidence interval of 95%
boot.ci(output, type="bca")

