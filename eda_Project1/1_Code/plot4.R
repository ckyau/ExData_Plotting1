# Read text file from folder
dat <- read.table("0_Data/household_power_consumption.txt",sep = ";", header = 1, stringsAsFactors = FALSE)

# Clean the dates in the dataframe
dat2 <- dat %>%
  mutate(date = lubridate::dmy(Date),
         dateTime = lubridate::dmy_hms(paste0(Date, " ", Time))) %>%
  filter(date >= "2007-02-01", date <= "2007-02-02")

# Change numbers from character to numeric
for (i in 3:9) {
  dat2[[i]] <- as.numeric(dat2[[i]])
}

# Plot 4  ------------------------------------------------------------------
# Split grid into four regions
par(mfcol = c(2, 2))

# Top left plot
plot(dat2$dateTime, dat2$Global_active_power, type = "l",  xlab = "", ylab = "Global Active Power")

# Bottom left plot
plot(dat2$dateTime, dat2$Sub_metering_1, type = "l",  xlab = "", ylab = "Energy sub metering")
lines(dat2$dateTime, dat2$Sub_metering_2, type = "l",  xlab = "", ylab = "Energy sub metering", col = "red")
lines(dat2$dateTime, dat2$Sub_metering_3, type = "l",  xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n")

# Top right plot
plot(dat2$dateTime, dat2$Voltage, type = "l",  xlab = "datetime", ylab = "Voltage")

# Bottom right plot
plot(dat2$dateTime, dat2$Global_reactive_power, type = "l",  xlab = "datetime", ylab = "Global_reactive_power")