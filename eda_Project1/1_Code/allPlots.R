# Load Libraries --------------------------------------------------------------------------------------------------------------------------------------
# Installs and loads packages ---------------------------------------------
for (func in list.files(path = "1_code/0_functions/")) { source(file = paste0("1_code/0_functions/", func)) }
installLoadPackages(c("tidyverse", "chron"), folderToInstallTo = "C:/Users/cyau/R/R-3.6.1/library")
rm(func, installLoadPackages)

# Load Libraries --------------------------------------------------------------------------------------------------------------------------------------
# Installs and loads packages ---------------------------------------------
install.packages("tidyverse")
library(tidyverse)

# Download Data -----------------------------------------------------------
path <- paste0(getwd(), "/household_power_consumption.zip")
if (!file.exists(path)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, path, method="curl")
  unzip(path) 
}  

dat <- read.table("0_Data/household_power_consumption.txt",sep = ";", header = 1, stringsAsFactors = FALSE)

dat2 <- dat %>%
  mutate(date = lubridate::dmy(Date),
         dateTime = lubridate::dmy_hms(paste0(Date, " ", Time))) %>%
  filter(date >= "2007-02-01", date <= "2007-02-02")


for (i in 3:9) {
  dat2[[i]] <- as.numeric(dat2[[i]])
}

# Plot 1 ------------------------------------------------------------------

plot1 <- hist(dat2$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red", ylim = c(0, 1200))

# Plot 2  ------------------------------------------------------------------

plot2 <- plot(dat2$dateTime, dat2$Global_active_power, type = "l",  xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot 3  ------------------------------------------------------------------

plot3 <- plot(dat2$dateTime, dat2$Sub_metering_1, type = "l",  xlab = "", ylab = "Energy sub metering")
lines(dat2$dateTime, dat2$Sub_metering_2, type = "l",  xlab = "", ylab = "Energy sub metering", col = "red")
lines(dat2$dateTime, dat2$Sub_metering_3, type = "l",  xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

# Plot 4  ------------------------------------------------------------------

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

# Copy plots to png device
dev.copy(png,filename = "plot1.png", width = 480, height = 480, units = "px")
dev.copy(png,filename = "plot2.png", width = 480, height = 480, units = "px")
dev.copy(png,filename = "plot3.png", width = 480, height = 480, units = "px")
dev.copy(png,filename = "plot4.png", width = 480, height = 480, units = "px")
dev.off(which = dev.cur())

