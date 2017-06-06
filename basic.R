rm(list = ls())
setwd("/Users/Piotr/Google Drive/Piotr-Gitbhub-Data/TimeUse/")
load(file = "./data.RData")
source("/Users/Piotr/Google Drive/Piotr-Gitbhub-Data/piotr-R-theme/piotr-R-theme.R")

dfNoAll <- df[df[,1] != "Total, all activities",]

require(ggplot2)

