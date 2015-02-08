##dplyr library is needed in order this script runs correctly
library(dplyr)

unzip("./exdata-data-household_power_consumption.zip") ##unzip data.If zip does not exist only a warning is shown.
energyUsage<-read.table("./household_power_consumption.txt",na.strings = "?",sep=";",header=TRUE) 
energyUsage<-energyUsage[energyUsage$Date %in% c("1/2/2007","2/2/2007"),] ##keep only the correct dates

##create a new column(using mutate method) tha contains both date and time as POSIXct type.
##In this way we will have the correct values in x-axis.
energyUsage<-mutate(energyUsage,DateAndTime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

##converting columns from factors to numeric
columnOfPowerAsNumeric<-as.numeric(as.character(energyUsage$Global_active_power))
SubMetering1AsNumeric<-as.numeric(as.character(energyUsage$Sub_metering_1))
SubMetering2AsNumeric<-as.numeric(as.character(energyUsage$Sub_metering_2))
SubMetering3AsNumeric<-as.numeric(as.character(energyUsage$Sub_metering_3))
columnOfVoltageAsNumeric<-as.numeric(as.character(energyUsage$Voltage))
columnOfReactPowerAsNumeric<-as.numeric(as.character(energyUsage$Global_reactive_power))

##creating the layout where our plots will be fit.
par(mfrow = c(2, 2),mar = c(3,4,4,1))

##top left Plot creation
with(energyUsage,plot(columnOfPowerAsNumeric ~ DateAndTime,type ="l",ylab ="Global Active Power (kilowatts)",xlab = ""))

##top right plot creation
with(energyUsage,plot(columnOfVoltageAsNumeric ~ DateAndTime,type ="l",ylab ="Voltage",xlab = "datetime"))

##bottom left plot creation
with(energyUsage,{
        plot(SubMetering1AsNumeric ~ DateAndTime,type ="l",ylab ="Energy sub metering",xlab = "")
        lines(SubMetering2AsNumeric ~ DateAndTime,type ="l",col="red")
        lines(SubMetering3AsNumeric ~ DateAndTime,col="blue")
        legend("topright",lty =1,,cex=0.7,bty = "n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
})

##bottom right plot creation
with(energyUsage,plot(columnOfReactPowerAsNumeric ~ DateAndTime,type ="l",ylab ="Global_reactive_power",xlab = "datetime"))

##create png file with appropriate name and close png graphic device
dev.copy(png, file = "./plot4.png")
dev.off()