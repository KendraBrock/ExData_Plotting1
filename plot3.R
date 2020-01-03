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

##Construct Plot 3
png(filename = "plot3.png", width = 480, height = 480)
##Reformat data
plot3_subset <- reshape2::melt(subset, id.vars = "DateTime", measure.vars = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot3_subset <- reshape2::melt(subset, id.vars = "DateTime", measure.vars = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot3 <- ggplot(plot3_subset, aes(x = DateTime, y = value, color = variable))+
  geom_line()+
  theme(legend.position = c(.87,.87))+
  theme(legend.title=element_blank())+
  xlab('')+
  ylab('Energy sub metering')+
  scale_colour_manual(values = c("black", "red", "blue"))
dev.off()