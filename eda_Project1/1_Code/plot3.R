# Read text file
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

# Plot 3  ------------------------------------------------------------------

plot(dat2$dateTime, dat2$Sub_metering_1, type = "l",  xlab = "", ylab = "Energy sub metering")
lines(dat2$dateTime, dat2$Sub_metering_2, type = "l",  xlab = "", ylab = "Energy sub metering", col = "red")
lines(dat2$dateTime, dat2$Sub_metering_3, type = "l",  xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))
