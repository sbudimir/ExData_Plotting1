# get the full dataset
data_full <- read.csv("./Data/household_power_consumption.txt", header=TRUE,
                      sep=';', na.strings="?",nrows=2075259, check.names=FALSE, 
                      stringsAsFactors=FALSE, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

# subset the dataset
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage", xlab="")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global_rective_power",xlab="")
})

# saving png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()