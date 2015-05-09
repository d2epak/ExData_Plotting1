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
png("plot3.png",width=480,height=480)

#since we have to plot multiple lines first initiate the plotting using the plot function and the first metric
plot((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Sub_metering_1,type='l',xlab='',ylab="Energy sub metering",col='black')

#then subsequently plot the remaining 2 metrics using the lines command
lines((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Sub_metering_2,type='l',xlab='',ylab="Energy sub metering",col='red')

lines((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Sub_metering_3,type='l',xlab='',ylab="Energy sub metering",col='blue')

#provide legend specifying the location of the legend,the metrics in the legend, the color for each of the metrics and the color indicator as well
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1))

#specify dev.off() to finally plot the graph to the file
dev.off()