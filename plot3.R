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

#
bytypeyear <- ddply(NEI, c("type", "year"), function(d){ sum(d$Emissions) })
names(bytypeyear) <- c("type","year","emissions")

#
g <- qplot(year, emissions, data = bytypeyear, facets = .~type)
print(g)