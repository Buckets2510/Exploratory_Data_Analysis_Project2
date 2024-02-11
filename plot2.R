## Script for Question 2
## Have total emissions from PM2.5 decreased in Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
## a plot answering this question.

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

#Subset Baltimore NEI data
baltNEI <- NEI[NEI$fips == "24510", ]

# Aggregate Baltimore emissions
baltTotal <- aggregate(Emissions ~ year, baltNEI, sum)

# Setup png file and plot
png("plot2.png", width = 480, height = 480, units = "px")
barplot(baltTotal$Emissions, main = "Total Baltimore PM2.5 Emissions", xlab = "Year", ylab = "PM2.5 Emissions",
        names.arg = baltTotal$year, ylim = c(0,4500))

dev.off()
