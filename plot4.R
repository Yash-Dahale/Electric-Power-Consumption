##Loading the data
df <- read.table("household_power_consumption.txt",header = TRUE,sep =";",na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

##Format Date column to type Date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

##Subset the data for 2 days
df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Omitting rows with incomplete observations
df <- df[complete.cases(df),]
## It turnes out that there are no incomplete data for given period of time

##combining date and time columns
dateTime <- paste(df$Date,df$Time)

##Name the vector
dateTime <- setNames(dateTime, "DateTime")

##Remove date and time column
df <- df[,!(names(df) %in% c("Date","Time"))]

##add date and time column
df <- cbind(dateTime,df)

##format dateTime
df$dateTime <- as.POSIXct(dateTime)








##plot 4

par(mfrow=c(2,2),mar=c(2, 4, 1, 1), oma=c(0,0,2,0))
with(df, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), 
         lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", 
                  "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})