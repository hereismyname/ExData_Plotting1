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

hist(usagedata$globalactivepower, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

png(file = "plot1.png") ## creates file in wd

hist(usagedata$globalactivepower, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

dev.off() ## closes graphics device
