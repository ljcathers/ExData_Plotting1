## Project 1, Plot 2
# Download and unzip the data file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method = "curl")
data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE,  as.is=TRUE)
unlink(temp)

#reformat the date field
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# subset out the data for the two days of data
library(dplyr)
data_sub <- filter(data, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))

# Get days data
rownames(data_sub) <- NULL
DateTime<- paste(as.Date(data_sub$Date), data_sub$Time)
data_sub$DateTime<- as.POSIXct(DateTime)

# create and save plot 2
png("./plot2.png",width=480, height=480)
plot(data_sub$Global_active_power ~ data_sub$DateTime, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()