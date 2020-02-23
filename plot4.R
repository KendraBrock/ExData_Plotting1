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

##Set up the framework
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

##Construct Plot 2
plot(subset$DateTime, subset$Global_active_power, type = "l", xlab = "", ylab = "Global active power (kilowats)")

##Create Voltage Plot
plot(subset$DateTime, subset$Voltage, type = "l", xlab = "DateTime", ylab = "Voltage")

##Construct Plot 3
sub1 <- subset$Sub_metering_1
sub2 <- subset$Sub_metering_2
sub3 <- subset$Sub_metering_3

plot(subset$DateTime, sub1, type = "l", ylab = "Energy sub metering", xlab="")
lines(subset$DateTime, sub2, type = "l", col = "red")
lines(subset$DateTime, sub3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, lwd=2.5)

##Create Global_reactive_power
plot(subset$DateTime, subset$Global_reactive_power, type = "l", xlab = "DateTime", ylab = "Global_reactive_power")

dev.off()