rm(list = ls())
setwd("/Users/Piotr/Google Drive/Piotr-Gitbhub-Data/TimeUse/")
load(file = "./2.intermed/data.RData")
source("/Users/Piotr/Google Drive/Piotr-Gitbhub-Data/piotr-R-theme/piotr-R-theme.R")

dfNoAll <- df[df[,1] != "Total, all activities",]

require(ggplot2)
require(sunburstR)
dfNoAll[,1] <- gsub("   ","",dfNoAll[,1])
dfNoAll[,1] <- gsub("- ","-",dfNoAll[,1])
bigPicture <- dfNoAll[!grepl("^-",dfNoAll[,1]),]
bigPicture2014 <- bigPicture[bigPicture[,11]==2014,]
bigPicture2014[,1] <- gsub("-", " ", bigPicture2014[,1])
sum(bigPicture2014[,2])
sunburst(bigPicture2014)