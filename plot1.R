############################

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

# head(data_sub)
# names(data_sub)

# create the histogram and save as a png file
library(datasets)
png("./plot1.png",width=480, height=480)
hist(data_sub$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts")
dev.off()
