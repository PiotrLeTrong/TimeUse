rm(list = ls())
setwd("C:/Users/piotr/Documents/GitHub/TimeUse")
load(file = "./2.intermed/data.RData")
require(ggplot2)
source("/Users/Piotr/Google Drive/Piotr-Gitbhub-Data/piotr-R-theme/piotr-R-theme.R")

dfNoAll <- df[df[,1] != "Total, all activities",]

require(ggplot2)
require(sunburstR)
dfNoAll[,1] <- gsub("   ","",dfNoAll[,1])
dfNoAll[,1] <- gsub("- ","-",dfNoAll[,1])
for(j in 1:5){
for(i in 1:nrow(dfNoAll)){
  if(grepl("^--",dfNoAll[i,1])){
    dfNoAll <- dfNoAll[-i,]
  }
  if(grepl("^--",dfNoAll[i,1])){
    dfNoAll <- dfNoAll[-i,]
  }
  if(grepl("^--",dfNoAll[i,1])){
    dfNoAll <- dfNoAll[-i,]
  }
}
}
for(i in 1:nrow(dfNoAll)){
    if(grepl("^-",dfNoAll[i,1])==FALSE){
      storeMajor <- dfNoAll[i,1]
    } else if(grepl("^-[A-z]",dfNoAll[i,1])==TRUE){
      storeMinor <- paste(storeMajor,dfNoAll[i,1], sep = "-")
      dfNoAll[i,1] <- (paste0(storeMajor,dfNoAll[i,1]))
    } else if(grepl("^--[A-z]",dfNoAll[i,1])==TRUE){
    # dfNoAll[i,1] <- (paste0(storeMinor,dfNoAll[i,1]))
    # dfNoAll[i,1] <- gsub("--", "-",dfNoAll[i,1])
    }
}
for(i in 1:nrow(dfNoAll)){
  if(!grepl("-",dfNoAll[i,1])){
    if(grepl("Other activities",dfNoAll[i,1])){
    } else{
      dfNoAll <- dfNoAll[-i,]
    }
  }
}

dfSmall <- dfNoAll[dfNoAll[,11]==2015,]
dfSmall <- dfSmall[,c(1,3)]

a <- dfNoAll[dfNoAll[,11]==2015,]
sum(a[,2])
sum(dfSmall[,2])

sunburst(dfSmall)

dfMajor <- df[!grepl("-",df[,1]),] 
dfMajor <- dfMajor[dfMajor[,1] != "Total, all activities",]
ggplot(data = dfMajor[dfMajor[,11]==2015,]) +
  geom_bar(aes(x = Activity, y = AvgDailyHoursMen), stat = "identity") +
  coord_flip() +
  theme_piotr()
ggplot(data = dfMajor[dfMajor[,11]==2015,]) +
  geom_bar(aes(x = Activity, y = AvgDailyHoursWomen), stat = "identity") +
  coord_flip() +
  theme_piotr()

dfBar <- dfMajor[,c(1,3,4,11)]
colnames(dfBar)[2:3] <- c("Men", "Women")
require(tidyr)
dfBar <- tidyr::gather(dfBar, "Gender", "Hours", 2:3)

ggplot(data = dfBar[dfBar[,2]==2015,]) +
  geom_bar(aes(x = reorder(Activity,Hours), y = Hours, fill = Gender), position = "dodge",stat = "identity") +
  coord_flip() +
  theme_piotr() +
  scale_y_continuous(breaks = seq(0,10,2))

dfBar0315 <- dfBar[dfBar[,2]==2003 | dfBar[,2]==2015,]

ggplot(data = dfBar0315[dfBar0315[,3]=="Men",]) +
  geom_bar(aes(x = reorder(Activity,Hours), y = Hours, fill = as.factor(Year)), position = "dodge", stat = "identity") +
  coord_flip() +
  theme_piotr() +
  scale_y_continuous(breaks = seq(0,10,2), limits = c(0,10))