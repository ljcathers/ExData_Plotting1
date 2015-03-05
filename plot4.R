## Project 1, Plot 4

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

# create and save plot 4
png("./plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(data_sub$Global_active_power ~ data_sub$DateTime, type = "l", ylab = "Global Active Power", xlab = "")
plot(data_sub$Voltage ~ data_sub$DateTime, type = "l", xlab = "datetime", ylab = "Voltage")
plot(data_sub$Sub_metering_1 ~ data_sub$DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data_sub$Sub_metering_2 ~ data_sub$DateTime, col = 'Red')
lines(data_sub$Sub_metering_3 ~ data_sub$DateTime, col = 'Blue')
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(data_sub$Global_reactive_power ~ data_sub$DateTime, type = "l", xlab = "datetime", ylab = "Global_rective_power")
dev.off()
