## Script for Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in emissions 
## from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
## 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

source("downloadZip.R")
library(ggplot2)

# Load the data NEI and SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset Baltimore NEI data
baltNEI <- NEI[NEI$fips == "24510", ]

# Aggregate Baltimore emissions
baltTotal <- aggregate(Emissions ~ year+ type, baltNEI, sum)

# Setup png file and plot
png("plot3.png", width = 480, height = 480, units = "px")
ggplot(baltTotal, aes(year, Emissions, color = type)) + geom_line() + 
        labs(x = "year", y = expression("Total PM2.5 Emissions")) + 
        ggtitle("PM2.5 Emissions, Baltimore City 1999 - 2008 by Source Type")

dev.off()
