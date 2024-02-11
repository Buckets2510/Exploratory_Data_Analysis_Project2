## Script for Question 4
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

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

#Subset coal combustion SCC data related to NEI
combRelate <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coalRelate <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
coalComb <- (combRelate & coalRelate)
combustionSCC <- SCC[coalComb,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

# Setup png file and plot
png("plot4.png", width = 480, height = 480, units = "px")
ggplot(combustionNEI, aes(year, Emissions)) + 
        geom_bar(stat = "identity", fill = "darkred", width = 0.75) + 
        labs(x = "year", y = expression("Total PM2.5 Emissions")) + 
        ggtitle("PM2.5 Coal Combustion Source Emissions Across US from 1999-2008")

dev.off()
