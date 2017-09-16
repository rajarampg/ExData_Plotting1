library(sqldf)

#Check for file in local space and initiate download
filename <- "getdata_dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, mode = "wb")
}  

if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

basedata<- read.csv.sql("household_power_consumption.txt", sep = ";","select * from file where Date in ('1/2/2007','2/2/2007')")
basedata$Date<-as.Date(basedata$Date,format= "%d/%m/%Y")
basedata$Time <- strptime(paste(basedata$Date,basedata$Time), "%Y-%m-%d %H:%M:%S")

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

plot(basedata$Time,basedata$Global_active_power,type = "l",xlab="", ylab="Global Active Power (kilowatts)")

plot(basedata$Time,basedata$Voltage,type = "l",xlab="datetime", ylab="Voltage")

plot(basedata$Time, basedata$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(basedata$Time, basedata$Sub_metering_2, type="l", col="red")
lines(basedata$Time, basedata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(basedata$Time, basedata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()