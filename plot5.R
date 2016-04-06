## This first line will likely take a few seconds. Be patient!
if(!exists('NEI')) { 
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists('SCC')) { 
    SCC <- readRDS("Source_Classification_Code.rds")
}

#
library(ggplot2)
library(dplyr)

# Subset with only data from Baltimore
NEI_baltimore <- subset(NEI, fips == "24510")

# Motor vehicle sources:
# Get all sources with "motor" or "Motor" in Short.Name
motor <- grep('[Mm]otor', SCC$Short.Name)

# Build data, with only records that match coal sources
NEI_baltimore_motor <- NEI_baltimore[NEI_baltimore$SCC %in% SCC[motor,c("SCC")],]

# Calculate totals by year
byyear <- with(NEI_baltimore_motor, tapply(Emissions, year, sum))
byyeardata <- data.frame(year = as.numeric(names(byyear)), total = as.numeric(byyear))

# Show barplot
barplot(byyeardata$total, names = byyeardata$year, main = "Emissions Motor vehicle sources in Baltimore City", xlab = "Year", ylab = "Emissions")

# Make PNG
dev.copy(png, file = "plot5.png", width = 800, height = 600)
dev.off()