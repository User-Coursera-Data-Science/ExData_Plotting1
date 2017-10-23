# Read table "household_power_consumption.txt"
power_consumption <- read.table("household_power_consumption.txt", sep=";", header = T,
                                stringsAsFactors = FALSE, dec = ".")

# Convert variables "Date" and "Time" to "Date/Time" classes
power_consumption$Date <- strptime(power_consumption$Date, "%d/%m/%Y")

# Filter only regiters within 2007-02-01 and 2007-02-02
dt <- subset(power_consumption, Date == "2007-02-01" | Date == "2007-02-02")

# Change Globa_active_power as numeric
dt$Global_active_power <- as.numeric(dt$Global_active_power)

# plot1 - histogram global_active_power
png("plot1.png",  width = 480, height = 480)
par(mfrow=c(1,1))
hist(dt$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
