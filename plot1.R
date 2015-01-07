#setwd("C:/Users/Ben/Downloads/Exploratory Data Analysis/Week 1/Project 1")
install.packages("data.table")
install.packages("Rcpp")
install.packages("plyr")
install.packages("reshape2")
library(plyr)
library(Rcpp)
library(reshape2)
library(data.table)

data <- fread("household_power_consumption.txt", na.strings= "?")
######### Data Cleaning #########
#Date :
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
# Subset the data for the two dates of interest
dataSubset <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]
# Convert to a data frame
dataSubset <- data.frame(dataSubset)
# Convert columns to numeric
for(i in c(3:9)) 
{
  dataSubset[,i] <- as.numeric(as.character(dataSubset[,i]))
}
# Create Date_Time variable
dataSubset$Date_Time <- paste(dataSubset$Date, dataSubset$Time)
# Convert Date_Time variable to proper format
dataSubset$Date_Time <- strptime(dataSubset$Date_Time, format="%Y-%m-%d %H:%M:%S")µ

###########################################################################################
# Reduced Data File
###########################################################################################
write.csv(dataSubset, file = "Home_Power_Consumption_Subset.csv")

###########################################################################################
#Plot 1
###########################################################################################
dataSubset <- read.csv("Home_Power_Consumption_Subset.csv")
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(6, 6, 5, 4))
hist(dataSubset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

