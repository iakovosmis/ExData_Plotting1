unzip("./exdata-data-household_power_consumption.zip") ##unzip data

energyUsage<-read.table("./household_power_consumption.txt",na.strings = "?",sep=";",header=TRUE) ##read data
energyUsage<-energyUsage[energyUsage$Date %in% c("1/2/2007","2/2/2007"),] ##keep only the correct dates

##create the histogram after converting the global power column from factor to numeric
columnOfPowerAsNumeric<-as.numeric(as.character(energyUsage$Global_active_power))
with(energyUsage,hist(columnOfPowerAsNumeric,col="red",main = "Global Active Power",xlab ="Global Active Power (kilowatts)"))

##create png file with appropriate name and close png graphic device
dev.copy(png, file = "./plot1.png")
dev.off()
