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
png("plot2.png",width=480,height=480)

# it is required to plot the Day of the Week on the X axis, so using paste concatenate the date and time together
# and using strptime generate the date and time in the format required
# finally pass this new date time as the x axis and the metric as y axis
# with type='l' to specify line graph
plot((strptime(paste(powerdata$Date,powerdata$Time), format="%d/%m/%Y %H:%M:%S")),powerdata$Global_active_power,type='l',xlab='',ylab='Global Active Power (Kilowats)')

#specify dev.off() to finally plot the graph to the file
dev.off()