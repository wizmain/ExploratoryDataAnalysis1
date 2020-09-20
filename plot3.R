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
# Convert Sub_metering_1,2,3 to numeric
household_pc <- mutate(household_pc, Sub_metering_1 = as.numeric(Sub_metering_1))
household_pc <- mutate(household_pc, Sub_metering_2 = as.numeric(Sub_metering_2))
household_pc <- mutate(household_pc, Sub_metering_3 = as.numeric(Sub_metering_3))

# sub data set
plot_data <- household_pc %>% filter(DateAsDate == "2007-02-01" | DateAsDate == "2007-02-02")

# make plot
with(plot_data,
     plot(x=DateTime,
          y=Sub_metering_1,
          type="l",
          xlab="",
          ylab="Energy sub metering")
)


with(plot_data,
     points(x=DateTime,
            y=Sub_metering_2,
            type="l",
            xlab="",
            col="red",
            ylab="Energy sub metering",
            ylim=range(Sub_metering_1, Sub_metering_2)
     )
)

with(plot_data,
     points(x=DateTime,
            y=Sub_metering_3,
            type="l",
            xlab="",
            col="blue",
            ylab="Energy sub metering",
            ylim=range(Sub_metering_1, Sub_metering_2)
     )
)

legend("topright", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=c(1,1,1))

# copy png
dev.copy(png, file="plot3.png")

# device off
dev.off()





