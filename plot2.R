##Set up libraries
library(dplyr)
library(data.table)
library(ggplot2)
library(gridExtra)

##Download file, if it does not exist.
if(!file.exists("./house_power/household_power_consumption.txt")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./householdpower.zip")
  unzip(zipfile = "./householdpower.zip", exdir = "./house_power")}
file.name <- "./house_power/household_power_consumption.txt"
housepower <- fread(file.name, header = TRUE, sep = ";", na.strings = "?")

##Subset for Feb 1, 2007 to Feb 2, 2007.
housepower[,DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
subset <- filter(housepower, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))

##Construct Plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot2 <- plot(subset$DateTime, subset$Global_active_power, type = "l", xlab = "", ylab = "Global active power (kilowats)")
print(plot2)
dev.off()