## Script for Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

source("downloadZip.R")
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
baltVehicleNEI$city <- "Baltimore City"

# Subset Los Angeles NEI data
LosVehicleNEI <- vehicleNEI[vehicleNEI$fips == "06037", ]
LosVehicleNEI$city <- "Los Angeles County"

# Combine the LA and Baltimore subsets
baltLosNEI <- rbind(baltVehicleNEI, LosVehicleNEI)

# Setup png file and plot
png("plot6.png", width = 480, height = 480, units = "px")
ggplot(baltLosNEI, aes(year, Emissions, fill = city)) + 
        geom_bar(aes(fill = year), stat = "identity") + 
        facet_grid(scales = "free", space = "free", .~city) + 
        labs(x = "year", y = expression("Total PM2.5 Emissions")) + 
        ggtitle("PM2.5 Motor Vehicle Source Emissions in Baltimore & LA from 1999-2008")

dev.off()
