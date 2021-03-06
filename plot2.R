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

# Plot 2
png(
    "plot2.png",
    width     = 480,
    height    = 480,
    units     = "px"
)
plot(filtereddata$DateTime, filtereddata$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()