library(ggplot2)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/data_w_mech.csv")
data <- data[data$res_ab!="8k",]
data$res_ab_f = factor(data$res_ab, levels=c('8k','10k','100k','1000k'))
data$pop_f = factor(data$pop, levels=c(100,200,500))
# Low mutation rate
data_l <- data[data$scf!=0 & data$mut=="l",] #Only low mutation condition at high res_ab, high pop
plot_l <- ggplot(data=data_l,aes(x=scf)) + geom_density()
plot_l <- plot_l + theme_minimal() + geom_vline(xintercept=8.78, linetype="dotted")
plot_l <- plot_l + xlab("Fitness (Births/Update)") + ylab("Density") + xlim(0,25) + ylim(0,1.0)
plot_l + facet_grid(pop_f~res_ab_f)

# High mutation rate
data_h <- data[data$scf!=0 & data$mut=="h",]
plot_h <- ggplot(data=data_h,aes(x=scf)) + geom_density()
plot_h <- plot_h + theme_minimal() + geom_vline(xintercept=8.78, linetype="dotted")
plot_h <- plot_h + xlab("Fitness (Births/Update)") + ylab("Density") + xlim(0,25)+ ylim(0,0.25)
plot_h + facet_grid(pop_f~res_ab_f)
