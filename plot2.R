# read data
data <- read.table(file = "household_power_consumption.txt", 
                   sep = ";", 
                   header = T, 
                   stringsAsFactors = FALSE,
                   na.strings = "?",
                   colClasses = c("factor", "factor","numeric", "numeric", "numeric", "numeric","numeric","numeric","numeric")
)
# copy data for backup / recovery
data.aux <- data
# check the data types
str(data)
# check the data
head(data)
# merge Date and Time
data$DateTime <- paste(data$Date, data$Time, sep = " ")
# transform to POSIXlt
data$DateTime <- strptime(data$DateTime, format = '%d/%m/%Y %H:%M:%S')
# transform to date data type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# check the data types
str(data)
# check the data
head(data)
# subset data for only the 2 desired dates
data.subset <- subset(data, data$Date >= '2007-02-01' & data$Date <= '2007-02-02')
# check the data types
str(data.subset)
# check the data
head(data.subset)

# plot Global_active_power across time
plot(data.subset$DateTime, data.subset$Global_active_power,
     type = "l",
     main = "",
     ylab = "Global Active Power (kilowatts)",
     xlab = "", 
     xaxt = "n")
axis.POSIXct(1, at=c('2007-02-01 00:00:00', '2007-02-02 00:00:00', '2007-02-03 00:00:00'), labels=c('Tue', 'Fri', 'Sat'))

dev.copy(png,'plot2.png', width = 480, height = 480)
dev.off()