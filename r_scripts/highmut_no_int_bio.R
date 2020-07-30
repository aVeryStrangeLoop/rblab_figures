library(ggplot2)
library(dplyr)
library(tidyr)

data0 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima0_no_int_bio.csv")
data1 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima1_no_int_bio.csv")
data2 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima2_no_int_bio.csv")
data3 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima3_no_int_bio.csv")

data0$peak <- as.factor(0)
data1$peak <- as.factor(1)
data2$peak <- as.factor(2)
data3$peak <- as.factor(3)

data <- data0
data <- rbind(data,data1)
data <- rbind(data,data2)
data <- rbind(data,data3)

p <- ggplot(data,aes(x=peak,y=(scf-scf_no_int_bio)/scf)) +
  geom_boxplot() + theme_minimal() +
  xlab("Peak") + ylab("Utility of internal bio. instructions") + theme(legend.position="None") 
p

