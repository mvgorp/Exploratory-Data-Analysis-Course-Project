## This first line will likely take a few seconds. Be patient!
if(!exists('NEI')) { 
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists('SCC')) { 
    SCC <- readRDS("Source_Classification_Code.rds")
}

#
library(ggplot2)
library(plyr)

# Subset with only data from Baltimore
NEI_baltimore <- subset(NEI, fips == "24510")

# Rebuild data by type and by year
bytypeyear <- ddply(NEI_baltimore, c("type", "year"), function(d){ sum(d$Emissions) })
names(bytypeyear) <- c("type","year","emissions")

# Plot
g <- qplot(year, emissions, data = bytypeyear, facets = .~type, geom = c("point", "smooth"), method = "lm", ylab = "Emissions", xlab = "Year", main = "Emissions Baltimore City, by type")
print(g)

# Make PNG
dev.copy(png, file = "plot3.png", width = 800, height = 600)
dev.off()