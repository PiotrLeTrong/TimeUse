library(XML)
library(openxlsx)
setwd("/Users/Piotr/Google Drive/Piotr-Gitbhub-Data/TimeUse/")

for(i in 1:12){
  assign(paste0("wrksrvy",i+2002), data.frame(read.xlsx("./a1_all_years.xlsx", sheet = 1, startRow = 3), year = i+2002))
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
  df[i,c(8:10)] <- as.numeric(gsub("--", "",df[i,c(8:10)]))
}

for(i in 1:nrow(df)){
  df[i,1] <- gsub("^    ", "-",df[i,1])
  df[i,1] <- gsub("^- ", "--",df[i,1])
}
df[,1] <- trimws(df[,1])
df[,8] <- as.numeric(df[,8])
df[,9] <- as.numeric(df[,9])
df[,10] <- as.numeric(df[,10])
df <- df[complete.cases(df[,2]),]
save(df, file = "./data.RData")