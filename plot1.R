## This first line will likely take a few seconds. Be patient!
if(!exists('NEI')) { 
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists('SCC')) { 
    SCC <- readRDS("Source_Classification_Code.rds")
}

# Calculate totals by year
byyear <- with(NEI, tapply(Emissions, year, sum))
byyeardata <- data.frame(year = as.numeric(names(byyear)), total = as.numeric(byyear))

# Plot
with(data, {
    
    # Show barplot
    barplot(byyeardata$total, names = byyeardata$year, main = "Total Emissions by Year", xlab = "Year", ylab = "Emissions (ton)")
    
})