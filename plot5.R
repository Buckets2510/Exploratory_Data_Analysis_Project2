## Script for Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## Download and save files, if they do not exist, for creating the plots

library("data.table")
path <- getwd()

fileName <- "NEI_data.zip"
if(!file.exists(fileName)) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url = fileURL, destfile = fileName)
}

if(!(file.exists("summarySCC_PM25.rds") && file.exists("Source_Classification_Code.rds"))) {
        unzip(fileName)
}

library(ggplot2)

# Load the data NEI and SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset vehicle data from SCC related to NEI
vehicleCon <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicleSCC <- SCC[vehicleCon,]$SCC
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

#Subset Baltimore NEI data
baltVehicleNEI <- vehicleNEI[vehicleNEI$fips == "24510", ]

# Setup png file and plot
png("plot5.png", width = 480, height = 480, units = "px")
ggplot(baltVehicleNEI, aes(year, Emissions)) + 
        geom_bar(stat = "identity", fill = "darkred", width = 0.75) + 
        labs(x = "year", y = expression("Total PM2.5 Emissions")) + 
        ggtitle("PM2.5 Motor Vehicle Source Emissions in Baltimore from 1999-2008")

dev.off()
