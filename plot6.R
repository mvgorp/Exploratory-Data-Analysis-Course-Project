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

# Subset with only data from Baltimore and LA + add fips name column
NEI_cities <- subset(NEI, fips == "24510" | fips == "06037")
NEI_cities$fips_name[NEI_cities$fips == "24510"] <- "Baltimore City"
NEI_cities$fips_name[NEI_cities$fips == "06037"] <- "Los Angeles County"

# Motor vehicle sources:
# Get all sources with "motor" or "Motor" in Short.Name
motor <- grep('[Mm]otor', SCC$Short.Name)

# Build data, with only records that match motor sources
NEI_cities_motor <- NEI_cities[NEI_cities$SCC %in% SCC[motor,c("SCC")],]

# Rebuild data by type and by year
byfipsyear <- ddply(NEI_cities_motor, c("fips_name", "year"), function(d){ sum(d$Emissions) })
names(byfipsyear) <- c("fips_name","year","emissions")

# Plot
g <- qplot(year, emissions, data = byfipsyear, facets = .~fips_name, geom = c("point", "smooth"), ylab = "Emissions", xlab = "Year", main = "Emissions Motor vehicles")
print(g)

# Make PNG
dev.copy(png, file = "plot6.png", width = 800, height = 600)
dev.off()