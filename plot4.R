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
dataSubset$Date_Time <- strptime(dataSubset$Date_Time, format="%Y-%m-%d %H:%M:%S")

###########################################################################################
# Reduced Data File
###########################################################################################
write.csv(dataSubset, file = "Home_Power_Consumption_Subset.csv")

###########################################################################################
#Plot 4
###########################################################################################
dataSubset <- read.csv("Home_Power_Consumption_Subset.csv")
dataSubset$Date_Time <- as.POSIXct(dataSubset$Date_Time)
#### Turn on png device and set parameters
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)
#### Plot 2 in top left
plot(dataSubset$Date_Time, dataSubset$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power", type="n")
lines(dataSubset$Date_Time, dataSubset$Global_active_power, type="S")
#### Top right graph


plot(dataSubset$Date_Time, dataSubset$Voltage, xaxt=NULL, xlab = "datetime", ylab = "Voltage", type="n")
lines(dataSubset$Date_Time, dataSubset$Voltage, type="S")
#### Plot 3 in bottom left
plot(dataSubset$Date_Time, dataSubset$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
lines(dataSubset$Date_Time, dataSubset$Sub_metering_1, col = "black", type = "S")
lines(dataSubset$Date_Time, dataSubset$Sub_metering_2, col = "red", type = "S")
lines(dataSubset$Date_Time, dataSubset$Sub_metering_3, col = "blue", type = "S")
legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#### Bottom right graph
plot(dataSubset$Date_Time, dataSubset$Global_reactive_power, xaxt=NULL, xlab = "datetime", ylab = "Global_reactive_power", type="n")
lines(dataSubset$Date_Time, dataSubset$Global_reactive_power, type="S")
#### Turn off device
dev.off()