# Load DPLYR package

library(dplyr)
library(ggplot2)

##Read Source files from working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset Data to consider only data rows related to baltimore City

Balt <- subset(NEI, fips == "24510")

## Subset data to look at only motor vehicle pollution

Baltrd<- subset(Balt, type == "ON-ROAD")


## Plot

png('plot5.png', width=600, height=480)
g <- ggplot(Baltrd, aes(factor(year), Emissions)) +
geom_bar(fill = "blue", stat="identity") +
  xlab("year") +
  ylab("PM2.5 Total Emissions") +
  ggtitle("Total Emissions from motor vehicle sources in Baltimore City")

print(g)
dev.off()
