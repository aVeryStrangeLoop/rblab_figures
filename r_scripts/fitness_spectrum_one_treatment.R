library(ggplot2)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/data_w_mech.csv")

# High mutation rate
data_h <- data[data$scf!=0 & data$mut=="h" & data$res_ab=="1000k" & data$pop==500,]
data_h
plot_h <- ggplot(data=data_h,aes(x=scf)) + geom_density()
plot_h <- plot_h + theme_minimal() + geom_vline(xintercept=8.78, linetype="dotted")
plot_h + xlab("Fitness (Births/Update)") + ylab("Density") + xlim(0,25) + ylim(0,1.5) +
  facet_wrap(~repl)

