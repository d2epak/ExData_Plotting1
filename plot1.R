#this package is included because we have to retrieve only certain records
#based on two dates

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
png("plot1.png",width=480,height=480)

#call histogram plotting function to plot for the metric Global_active_power, provide title,specify filling as red and x label per requirement
hist(powerdata$Global_active_power,main="Global Active Power",col='red',xlab="Global Active Power (kilowatts)")

#specify dev.off() to finally plot the graph to the file
dev.off()
