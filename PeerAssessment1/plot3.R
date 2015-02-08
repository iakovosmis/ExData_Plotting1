##dplyr library is needed in order this script runs correctly
library(dplyr)

unzip("./exdata-data-household_power_consumption.zip") ##unzip data
energyUsage<-read.table("./household_power_consumption.txt",na.strings = "?",sep=";",header=TRUE) ##read data
energyUsage<-energyUsage[energyUsage$Date %in% c("1/2/2007","2/2/2007"),] ##keep only the correct dates

##create a new column(using mutate method) tha contains both date and time as POSIXct type.
##In this way we will have the correct values in x-axis.
energyUsage<-mutate(energyUsage,DateAndTime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

SubMetering1AsNumeric<-as.numeric(as.character(energyUsage$Sub_metering_1))
SubMetering2AsNumeric<-as.numeric(as.character(energyUsage$Sub_metering_2))
SubMetering3AsNumeric<-as.numeric(as.character(energyUsage$Sub_metering_3))

##create the plot that contains 3 different lines with different color
with(energyUsage,{
        plot(SubMetering1AsNumeric ~ DateAndTime,type ="l",ylab ="Energy sub metering",xlab = "")
        lines(SubMetering2AsNumeric ~ DateAndTime,type ="l",col="red")
        lines(SubMetering3AsNumeric ~ DateAndTime,col="blue")
        legend("topright",lty =1,cex=0.45,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
        })

##create png file with appropriate name and close png graphic device
dev.copy(png, file = "./plot3.png")
dev.off()