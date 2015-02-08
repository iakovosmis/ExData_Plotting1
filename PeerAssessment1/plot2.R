##dplyr library is needed in order this script runs correctly
library(dplyr)

unzip("./exdata-data-household_power_consumption.zip") ##unzip data.If zip does not exist only a warning is shown.
energyUsage<-read.table("./household_power_consumption.txt",na.strings = "?",sep=";",header=TRUE) ##read data

##keep only the correct dates
energyUsage<-energyUsage[energyUsage$Date %in% c("1/2/2007","2/2/2007"),] 

##create a new column(using mutate method) tha contains both date and time as POSIXct type.
##In this way we will have the correct values in x-axis.
energyUsage<-mutate(energyUsage,DateAndTime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))


##create the histogram after converting the global power column from factor to numeric
columnOfPowerAsNumeric<-as.numeric(as.character(energyUsage$Global_active_power))
with(energyUsage,plot(columnOfPowerAsNumeric ~ DateAndTime,type ="l",ylab ="Global Active Power (kilowatts)",xlab = ""))

##create png file with appropriate name and close png graphic device
dev.copy(png, file = "./plot2.png")
dev.off()