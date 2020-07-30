library(ggplot2)
library(dplyr)
library(tidyr)

data0 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima0_tasks.csv")
data1 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima1_tasks.csv")
data2 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima2_tasks.csv")
data3 <- read.csv("~/wsl_files/rblab/rblab_figures/data/highmut_samples_100/genomes_maxima3_tasks.csv")

data0$peak <- as.factor(0)
data1$peak <- as.factor(1)
data2$peak <- as.factor(2)
data3$peak <- as.factor(3)

data <- data0
data <- rbind(data,data1)
data <- rbind(data,data2)
data <- rbind(data,data3)


## Plot merits
p_merit <- ggplot(data,aes(x=peak,y=merit,color=factor(1))) +
  geom_boxplot() + ylim(105,NA) + theme_minimal() +
  xlab("Peak") + ylab("Merit") + theme(legend.position="None")
p_merit


## Plot task spectrum
data_reshaped <- data %>% select(peak, task.0, task.1, task.2, task.3, task.4, task.5, task.6, task.7, task.8) %>%
  pivot_longer(., cols = c(task.0,task.1,task.2,task.3,task.4,task.5,task.6,task.7,task.8), names_to = "task", values_to = "num")

data_reshaped

p_task <- ggplot(data_reshaped,aes(x=task,y=num,fill=peak)) + geom_boxplot(outlier.shape = NA) 
p_task  + coord_cartesian(ylim=c(0, 200)) + facet_grid(peak~.,labeller = label_both) + theme_minimal() + 
  xlab("Task Complexity") + ylab("Instances per genome") + theme(legend.position = "None") +
  scale_x_discrete(labels= task_labels)

check_data <- data_reshaped[data_reshaped$peak==4 & data_reshaped$task=="task.8",]
quantile(check_data$num)

