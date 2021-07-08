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

##plot 2
par(mfrow=c(1,1),mar=c(5,4.5,4,2))
plot(df$Global_active_power~df$dateTime,type = "l",xlab = "",ylab = "Global Active power (kilowatts)")

##dev.off()
