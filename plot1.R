## Script for Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

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

# Load the data NEI and SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Aggregate total emissions for 1999, 2002, 2005, and 2008
emiTotals <- aggregate(Emissions ~ year, NEI, sum)

# Setup png file and plot
png("plot1.png", width = 480, height = 480, units = "px")
barplot(emiTotals$Emissions/1000, main = "Total PM2.5 Emissions", xlab = "Year", ylab = "PM2.5 Emissions",
        names.arg = emiTotals$year, ylim = c(0,8500))

dev.off()
