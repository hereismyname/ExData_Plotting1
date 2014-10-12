if (!file.exists("powerdata")) {
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    download.file(url, "powerdata.zip")
    
    dir.create("powerdata")
    
    unzip("powerdata.zip", exdir = "powerdata")
}

setwd("./powerdata")

## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## One alternative is to read the data from just those dates rather than reading
## in the entire dataset and subsetting to those dates.

usagedata <- read.table("household_power_consumption.txt", sep = ";",
                        na.strings = "?", stringsAsFactors = FALSE, 
                        skip = 66638, nrow = 2879)

powercolnames <- c("date", "time", "globalactivepower", "globalreactivepower", 
                   "voltage", "globalintensity", "submetering1", "submetering2",
                   "submetering3")

names(usagedata) <- powercolnames

usagedata[[1]] <- as.Date(usagedata[[1]], "%d/%m/%Y")

usagedata$datetime <- paste(usagedata[[1]], usagedata[[2]])

usagedata[[10]] <- strptime(usagedata[[10]], "%Y-%m-%d %H:%M:%S")

## windows(width=10, height=8)
## I've needed this command to display my legends at the correct size...
## Seems to be a hardware/software issue with RStudio.

plot(usagedata$datetime, usagedata$submetering1, type = "l", 
     ylab = "Energy Sub Metering", xlab = "")
lines(usagedata$datetime, usagedata$submetering2, type = "l", col = "Red")
lines(usagedata$datetime, usagedata$submetering3, type = "l", col = "Blue")
legend("topright", 
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
       col = c("black", "red", "blue"), lwd = 2, bty = "n", xjust = 1,
       lty = c(1,1), seg.len = 1, cex = 1)

png("Plot3.png")

plot(usagedata$datetime, usagedata$submetering1, type = "l", 
     ylab = "Energy Sub Metering", xlab = "")
lines(usagedata$datetime, usagedata$submetering2, type = "l", col = "Red")
lines(usagedata$datetime, usagedata$submetering3, type = "l", col = "Blue")
legend("topright", 
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
       col = c("black", "red", "blue"), lwd = 2, bty = "n", xjust = 1,
       lty = c(1,1), seg.len = 1, cex = 1)

dev.off()