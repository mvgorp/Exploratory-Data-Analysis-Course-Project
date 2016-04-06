## This first line will likely take a few seconds. Be patient!
if(!exists('NEI')) { 
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists('SCC')) { 
    SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset with only data from Baltimore
NEI_baltimore <- subset(NEI, fips == "24510")

# Calculate by year
byyear <- with(NEI_baltimore, tapply(Emissions, year, sum))
byyeardata_balt <- data.frame(year = as.numeric(names(byyear)), total = as.numeric(byyear))

# Show barplot
barplot(byyeardata_balt$total, names = byyeardata_balt$year, main = "Total Emissions by Year in Baltimore", xlab = "Year", ylab = "Emissions")

# Make PNG
dev.copy(png, file = "plot2.png", width = 800, height = 600)
dev.off()