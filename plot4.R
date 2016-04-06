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

# Coal combustion-related sources:
# Get all sources with "coal" or "Coal" in Short.Name
coal <- grep('[Cc]oal', SCC$Short.Name)

# Build data, with only records that match coal sources
NEI_coal <- NEI[NEI$SCC %in% SCC[coal,c("SCC")],]

# Calculate totals by year
byyear <- with(NEI_coal, tapply(Emissions, year, sum))
byyeardata <- data.frame(year = as.numeric(names(byyear)), total = as.numeric(byyear))

# Show barplot
barplot(byyeardata$total, names = byyeardata$year, main = "Emissions Coal related sources", xlab = "Year", ylab = "Emissions")

# Make PNG
dev.copy(png, file = "plot4.png", width = 800, height = 600)
dev.off()