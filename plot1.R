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
png("plot1.png", width=480, height=480)
hist(as.numeric(basedata$Global_active_power), col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
