# Read table "household_power_consumption.txt"
power_consumption <- read.table("household_power_consumption.txt", sep=";", header = T,
                                stringsAsFactors = FALSE, dec = ".")

# Convert variables "Date" and "Time" to "Date/Time" classes
power_consumption$Date <- strptime(power_consumption$Date, "%d/%m/%Y")

# Filter only regiters within 2007-02-01 and 2007-02-02
dt <- subset(power_consumption, Date == "2007-02-01" | Date == "2007-02-02")

# Change Globa_active_power as numeric
dt$Global_active_power <- as.numeric(dt$Global_active_power)

library(dplyr)
# Create variable with Date and Time together
dt_plot2 <- mutate(dt, Date_time = paste(Date, Time, sep = " "))
dt_plot2$Date_time <- as.POSIXct(dt_plot2$Date_time)

# plot3 - date/time x energy sub metering x color = type sub metering
png("plot3.png",  width = 480, height = 480)
par(mfrow=c(1,1))
with(dt_plot2,plot(Sub_metering_1 ~ Date_time, type = "l", xlab = "",
                   ylab = "Energy sub metering"))
with(dt_plot2,points(Sub_metering_2 ~ Date_time, type = "l", col = "red"))
with(dt_plot2,points(Sub_metering_3 ~ Date_time, type = "l", col = "blue"))
legend("topright", lty = 1, lwd = 2, col = c("black","red","blue"), legend = c("Sub_metering_1",
                                                                               "Sub_metering_2","Sub_metering_3"))
dev.off()
