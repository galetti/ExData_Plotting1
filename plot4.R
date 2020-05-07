library(dplyr)
library(lubridate)

# Load the data
filename <- ".\\household_power_consumption.txt"
data <- read.table(filename, sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Convert date to numeric
data[,-(1:2)] <- lapply(data[,-(1:2)], as.numeric)

# Filter data for correct date
filtereddata <- data %>%
    filter(Date == "1/2/2007" | Date =="2/2/2007")

# Convert Date and Time
cols = c("Date", "Time")
filtereddata$DateTime <- apply(filtereddata[, cols ], 1, paste, collapse = " " )

filtereddata$DateTime <- as.POSIXct(strptime(filtereddata$DateTime, "%d/%m/%Y %H:%M:%S"))

# Plot 4
png(
    "plot4.png",
    width     = 480,
    height    = 480,
    units     = "px"
)
par(
    mfrow = c(2,2)
)
plot(filtereddata$DateTime, filtereddata$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

plot(filtereddata$DateTime, filtereddata$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

plot(filtereddata$DateTime, filtereddata$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(filtereddata$DateTime, filtereddata$Sub_metering_2, col = "red")
lines(filtereddata$DateTime, filtereddata$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),
       lty = 1, bty = "n")

plot(filtereddata$DateTime, filtereddata$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()