library(dplyr)
data <- read.csv("../data/data_w_mech.csv")

data_sub <- data[data$scf!=0 & data$mut=="h",] #Only low mutation condition at high res_ab, high pop
summary(data_sub)

library(ggplot2)
p <- ggplot(data_sub,aes(x=scf)) + geom_density()
p


data_density <- density(data_sub$scf)
density_1 <- cbind("x"=data_density$x,"y"=data_density$y)
density_1 <- as.data.frame(density_1)
density_1

bw <- data_density$bw
bw

max_1 <- density_1$x[which.max(density_1$y)]
max_1

density_2 <- density_1[density_1$x>15 & density_1$x<20,]
max_2 <- density_2$x[which.max(density_2$y)]
max_2

density_3 <- density_1[density_1$x>20,]
max_3 <- density_3$x[which.max(density_3$y)]
max_3


density_0 <- density_1[density_1$x<5,]
max_0 <- density_0$x[which.max(density_0$y)]
max_0


data_0 <- data_sub[data_sub$scf>max_0-bw/2 & data_sub$scf<max_0+bw/2,]
data_1 <- data_sub[data_sub$scf>max_1-bw/2 & data_sub$scf<max_1+bw/2,]
data_2 <- data_sub[data_sub$scf>max_2-bw/2 & data_sub$scf<max_2+bw/2,]
data_3 <- data_sub[data_sub$scf>max_3-bw/2 & data_sub$scf<max_3+bw/2,]


data_0$peak <- 0
data_1$peak <- 1
data_2$peak <- 2
data_3$peak <- 3

data_0 <- sample_n(data_0,100)
data_1 <- sample_n(data_1,100)
data_2 <- sample_n(data_2,100)
data_3 <- sample_n(data_3,100)


write.csv(data_0,"../data/genomes_maxima0.csv",row.names=FALSE)
write.csv(data_1,"../data/genomes_maxima1.csv",row.names=FALSE)
write.csv(data_2,"../data/genomes_maxima2.csv",row.names=FALSE)
write.csv(data_3,"../data/genomes_maxima3.csv",row.names=FALSE)

