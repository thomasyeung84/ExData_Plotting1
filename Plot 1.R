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
png ("plot1.png", width = 480, height = 480, units = "px")

## Plot the histogram
with (datasubset, hist (Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

dev.off()






