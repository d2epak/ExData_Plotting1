library(sqldf)

getwd()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="powerconsumption.zip")

file<-unzip("powerconsumption.zip")

#in order to view the data and the formats read the first 100000 rows
power <- read.csv(file, header=TRUE,sep=";",nrows=100000)

# see the format of the date to be used in filtering
unique(power$Date)


#specify the filter criteria to select only the 2 dates 
powerdata <- read.csv.sql(file, sql = "select * from file where (Date = '1/2/2007' or Date ='2/2/2007') ",header=TRUE,sep=";")

#call the png function to initiate plotting to a png file, specify name of the file and width and height
png("plot4.png",width=480,height=480)

#since we have to plot 4 graphs specify that 2 rows and 2 columns are required to be filled up
par(mfrow = c(2,2))

#plot the first graph on the top left corner
plot((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Global_active_power,type='l',xlab='',ylab="Global Active Power",col='black')

#plot the second graph on the top right corner
plot((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Voltage,type='l',xlab='datetime',ylab="Voltage",col='black')

#plot the third graph on the bottom left corner
plot((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Sub_metering_1,type='l',xlab='',ylab="Energy sub metering",col='black')

lines((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Sub_metering_2,type='l',xlab='',ylab="Energy sub metering",col='red')

lines((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Sub_metering_3,type='l',xlab='',ylab="Energy sub metering",col='blue')

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1),bty="n")

#plot the fourth graph on the bottom right corner
plot((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Global_reactive_power,type='l',xlab='datetime',ylab="Global_reactive_power",col='black')

#specify dev.off() to finally plot the graph to the file
dev.off()