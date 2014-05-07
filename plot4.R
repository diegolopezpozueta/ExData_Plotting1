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

# 4 plots in 1 page
par(mfrow=c(2,2))

# plot Global_active_power across time
plot(data.subset$DateTime, data.subset$Global_active_power,
     type = "l",
     main = "",
     ylab = "Global Active Power (kilowatts)",
     xlab = "", 
     xaxt = "n")
axis.POSIXct(1, at=c('2007-02-01 00:00:00', '2007-02-02 00:00:00', '2007-02-03 00:00:00'), labels=c('Tue', 'Fri', 'Sat'))

# plot Voltage across time
plot(data.subset$DateTime, data.subset$Voltage,
     type = "l",
     main = "",
     ylab = "Voltage",
     xlab = "datetime", 
     xaxt = "n")
axis.POSIXct(1, at=c('2007-02-01 00:00:00', '2007-02-02 00:00:00', '2007-02-03 00:00:00'), labels=c('Tue', 'Fri', 'Sat'))

# plot Sub_metering across time
plot(data.subset$DateTime, data.subset$Sub_metering_1,
     type = "l",
     main = "",
     ylab = "Energy sub mettering",
     xlab = "", 
     xaxt = "n")
axis.POSIXct(1, at=c('2007-02-01 00:00:00', '2007-02-02 00:00:00', '2007-02-03 00:00:00'), labels=c('Tue', 'Fri', 'Sat'))
lines (data.subset$DateTime, data.subset$Sub_metering_2, col = 'red')
lines (data.subset$DateTime, data.subset$Sub_metering_3, col = 'blue')
# legend("topright", 
#        lty=c(1,1,1), 
#        cex = 0.5,
#        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
#        col=c("black", "red", "blue"), inset=.05,
#        box.col = "white")

# plot Global_reactive_power across time
plot(data.subset$DateTime, data.subset$Global_reactive_power,
     type = "l",
     main = "",
     ylab = "Global_reactive_power",
     xlab = "datetime", 
     xaxt = "n")
axis.POSIXct(1, at=c('2007-02-01 00:00:00', '2007-02-02 00:00:00', '2007-02-03 00:00:00'), labels=c('Tue', 'Fri', 'Sat'))

# back to 1 plot per page
par(mfrow=c(1,1))

# save plot to png
dev.copy(png,'plot4.png', width = 1200, height = 1200)
dev.off()

