## download the file
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename = "household_power_consumption.txt"

if (!file.exists(filename)) {
        temp <- tempfile()
        download.file(fileurl, temp)
        unzip (temp, filename)
        unlink(temp)
        rm (temp)
}


## loading the required observation 
datasubset <- read.table(filename, sep = ";", na.strings = "?", skip = 66637, nrow = 69517-66637, col.names = colnames (read.table(filename, sep = ";", header = TRUE, nrow = 2)))

## formating the Date column
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
datasubset$Date <- as.Date (datasubset$Date, format = "%d/%m/%Y")
Sys.setlocale("LC_TIME", lct)
## creating a DateTime coloum
datasubset$DateTime <- paste (datasubset$Date, datasubset$Time, sep = " ")

## formatting the DateTime coloum
datasubset$DateTime <- strptime (datasubset$DateTime, "%Y-%m-%d %H:%M:%S")

## open PNG device 
png ("plot4.png", width = 480, height = 480, units = "px")

## set the frame 
par (mfrow = c(2,2))

## plot the first graph
with (datasubset, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

## plot the second graph
with (datasubset, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

## plot the third graph
plot (datasubset$DateTime, datasubset$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = "")
with (datasubset, lines(DateTime, Sub_metering_1))
with (datasubset, lines(DateTime, Sub_metering_2, col = "red"))
with (datasubset, lines(DateTime, Sub_metering_3, col = "blue"))
legend ("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

## plot the forth graph
with (datasubset, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

dev.off() 


