rm(list = ls())
setwd("C:/Users/piotr/Documents/GitHub/TimeUse")
load(file = "./2.intermed/data.RData")
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

dfNoAll2014Total <- dfNoAll[dfNoAll[,11]==2014,]
dfNoAll2014Total <- dfNoAll2014Total[,c(1,2)]

a <- dfNoAll[dfNoAll[,11]==2014,]
sum(a[,2])
sum(dfNoAll2014Total[,2])

sunburst(dfNoAll2014Total)