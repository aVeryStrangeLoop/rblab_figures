data <- read.csv("~/wsl_files/rblab/rblab_figures/data/peak_fractions_bs.csv")
data_l <- data[data$mut=="l",]
data_h <- data[data$mut=="h",]
library(stringr)
data_l$res <- as.numeric(str_sub(as.character(data_l$res),1,-2))
data_l <- data_l[data_l$res!=8,]
data_h$res <- as.numeric(str_sub(as.character(data_h$res),1,-2))
data_h <- data_h[data_h$res!=8,]

data_l$pop <- as.factor(data_l$pop)
data_h$pop <- as.factor(data_h$pop)
data_l$res <- as.factor(data_l$res)
data_h$res <- as.factor(data_h$res)
data_l
library(ARTool)
library(emmeans)
## L0
model = art(p0 ~ pop + res + pop:res,
            data = data_l)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")

## L1
model = art(p1 ~ pop + res + pop:res,
            data = data_l)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")

## L2
model = art(p2 ~ pop + res + pop:res,
            data = data_l)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")


## L3
model = art(p3 ~ pop + res + pop:res,
            data = data_l)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")


## L4
model = art(p4 ~ pop + res + pop:res,
            data = data_l)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")


########################################################3

## H0
model = art(p0 ~ pop + res + pop:res,
            data = data_h)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")

## H1
model = art(p1 ~ pop + res + pop:res,
            data = data_h)
anova(model)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")

## H2
model = art(p2 ~ pop + res + pop:res,
            data = data_h)
anova(model)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")

## H3
model = art(p3 ~ pop + res + pop:res,
            data = data_h)
model.int = artlm(model, "pop:res")
marginal = emmeans(model.int, ~ pop:res)
contrast(marginal, method="pairwise", adjust="none")
