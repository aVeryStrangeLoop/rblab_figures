library(ggplot2)
data <- read.csv("~/wsl_files/rblab/rblab_figures/data/data_w_mech.csv")

# Low mutation rate
data_l <- data[data$scf!=0 & data$mut=="l" & data$res_ab=="10k" & data$pop==500,] #Only low mutation condition at high res_ab, high pop
plot_l <- ggplot(data=data_l,aes(x=scf)) + geom_density()
plot_l <- plot_l + geom_line(data= data[data$scf!=0 & data$mut=="l",],aes(group=interaction(pop,res_ab)),stat="density", alpha=0.1)
plot_l <- plot_l + theme_minimal() + geom_vline(xintercept=8.78,linetype="dotted")
plot_l + xlab("Fitness (Births/Update)") + ylab("Density") + xlim(0,25) + ylim(0,1)

# High mutation rate
data_h <- data[data$scf!=0 & data$mut=="h" & data$res_ab=="10k" & data$pop==500,]
plot_h <- ggplot(data=data_h,aes(x=scf)) + geom_density()
plot_h <- plot_h + geom_line(data= data[data$scf!=0 & data$mut=="h",],aes(group=interaction(pop,res_ab)),stat="density", alpha=0.1)
plot_h <- plot_h + theme_minimal() + geom_vline(xintercept=8.78,linetype="dotted")
plot_h + xlab("Fitness (Births/Update)") + ylab("Density") + xlim(0,25) + ylim(0,0.5)

