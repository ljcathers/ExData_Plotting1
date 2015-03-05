## Project 1, Plot 3

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

# create and save plot 3
png("./plot3.png", width=480, height=480)
plot(data_sub$Sub_metering_1 ~ data_sub$DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data_sub$Sub_metering_2 ~ data_sub$DateTime, col = 'Red')
lines(data_sub$Sub_metering_3 ~ data_sub$DateTime, col = 'Blue')
legend("topright", lty=1, col=c("black","blue","red"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
