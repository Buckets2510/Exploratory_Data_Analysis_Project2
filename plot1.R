## Script for Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

source("downloadZip.R")

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
