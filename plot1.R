library(dplyr)

# read data file
household_pc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F)
# check out imported dataframe
str(household_pc)

# convert Date string to Date format
household_pc <- mutate(household_pc, DateAsDate = as.Date(Date,"%d/%m/%Y"))

# Date + Time make DateTime String
household_pc <- mutate(household_pc, DateTime = paste(Date, Time,sep=" "))
# Convert DateTime format
household_pc <- mutate(household_pc, DateTime = as.POSIXct(DateTime, format="%d/%m/%Y %H:%M:%S"))

# Convert Global_active_power to Numeric
household_pc <- mutate(household_pc, Global_active_power = as.numeric(Global_active_power))

# make histogram
household_pc %>% filter(DateAsDate == "2007-02-01" | DateAsDate == "2007-02-02") %>%
        with(
                hist(Global_active_power
                     , col="red"
                     , xlab="Global Active Power (kilowatts)"
                     , main="Global Active Power")
        )

# copy png
dev.copy(png, file="plot2.png")

# device off
dev.off()
