rm(list = ls())
library(XML)
library(openxlsx)
setwd("C:/Users/piotr/Documents/GitHub/TimeUse")

for(i in 1:13){
  assign(paste0("wrksrvy",i+2002), data.frame(read.xlsx("./1.data/a1_all_years.xlsx", sheet = i, startRow = 3), year = i+2002))
}

l.df <- lapply(ls(pattern="wrksrvy"), function(x){get(x)})
l.df <- lapply(l.df, function(x){
  colnames(x) <- c("Activity",
                   "AvgDailyHoursTotal",
                   "AvgDailyHoursMen",
                   "AvgDailyHoursWomen",
                   "AvgPctPeopleDidThisTotal",
                   "AvgPctPeopleDidThisMen",
                   "AvgPctPeopleDidThisWomen",
                   "AvgDailyHoursWhoDidTotal",
                   "AvgDailyHoursWhoDidMen",
                   "AvgDailyHoursWhoDidWomen",
                   "Year")
  x
})
df <- do.call("rbind", l.df)
df <- as.data.frame(df)
for(i in 1:nrow(df)){
  df[i,c(2:10)] <- as.numeric(gsub("--", "",df[i,c(2:10)]))
}


for(i in 1:nrow(df)){
  df[i,1] <- gsub("-", " ", df[i,1])
  df[i,1] <- gsub("^    ", "-",df[i,1])
  df[i,1] <- gsub("^- ", "--",df[i,1])
}
df[,1] <- trimws(df[,1])
for(i in 2:ncol(df)){
  df[,i] <- as.numeric(df[,i])
}
df <- df[complete.cases(df[,2]),]
save(df, file = "./2.intermed/data.RData")