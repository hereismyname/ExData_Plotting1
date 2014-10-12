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

plot(usagedata$datetime, usagedata$globalactivepower, type = "l", xlab="",
     ylab= "Global Active Power (kilowatts)")

png("Plot2.png")

plot(usagedata$datetime, usagedata$globalactivepower, type = "l", xlab="",
     ylab= "Global Active Power (kilowatts)")

dev.off()