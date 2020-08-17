# Load DPLYR package

library(dplyr)
library(ggplot2)

##Read Source files from working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetdata by location and source type

Balt<-subset(NEI, fips == "24510" & type == "ON-ROAD")
LA<-subset(NEI, fips == "06037" & type == "ON-ROAD")

## Create new dataframe containing aggregated data for both Baltimore and LA
## sorted by year

Baltdat <- aggregate(Emissions ~ year, Balt, sum)
Baltdat$loc<-"Baltimore City"
LAdat<- aggregate(Emissions ~ year, LA, sum)
LAdat$loc<-"Los Angeles County"

combinedData <- as.data.frame(rbind(Baltdat, LAdat))

## Create plot

png('plot6.png', width=600, height=480)

g <- ggplot(combinedData, aes(factor(year), Emissions, fill=year)) + guides(fill=FALSE)+
facet_grid(. ~ loc) + geom_bar(stat="identity") +
  xlab("year") +
  ylab("PM2.5 Total Emissions") +
  ggtitle("Total Emissions from motor vehicle sources in Baltimore City and Los Angeles County")

print(g)
dev.off()
