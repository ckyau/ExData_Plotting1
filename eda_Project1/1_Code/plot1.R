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

# Plot 1 ------------------------------------------------------------------

plot1 <- hist(dat2$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red", ylim = c(0, 1200))