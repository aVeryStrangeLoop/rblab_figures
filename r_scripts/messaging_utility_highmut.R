library(ggplot2)
library(dplyr)
library(tidyr)

data0 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima0.csv")
data1 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima1.csv")
data2 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima2.csv")
data3 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima3.csv")

data0$peak <- as.factor(0)
data1$peak <- as.factor(1)
data2$peak <- as.factor(2)
data3$peak <- as.factor(3)

data <- data0
data <- rbind(data,data1)
data <- rbind(data,data2)
data <- rbind(data,data3)

## Plot merits
p_mum <- ggplot(data,aes(x=peak,y=(scf-del_msg_scf) / scf,color=1)) +
  geom_jitter(aes(alpha=0.0001),width=0.2) + geom_boxplot(outlier.shape = NA) + coord_cartesian(ylim=c(NA, 0.5)) + theme_minimal()  +
  xlab("Peak") + ylab("Marginal utility of messaging") + theme(legend.position="None")
p_mum

