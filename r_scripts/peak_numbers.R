library(ggplot2)
library(viridis)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/peak_fractions.csv")
data$res_f = factor(data$res, levels=c('8k','10k','100k','1000k'))
data$pop_f = factor(data$pop, levels=c(100,200,500))

data_h <- data[data$mut=="l" & data$res!="8k",]

p <- ggplot(data_h,aes(x=res_f,y=pop_f)) + 
  geom_tile(aes(fill=p4)) +
  scale_fill_viridis(option="magma",limits=c(0,0.31)) +
  theme_minimal() +
  xlab("Resource abundance") +
  ylab("Carrying capacity") +
  labs(fill="Proportion")
p

## Palettes
## p0 Greens
## p1 blues
## p2 Oranges
## p3 Purples
## p4 Reds

