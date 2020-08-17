### Load DPLYR package

library(dplyr)
library(ggplot2)

##Read Source files from working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset Data to consider only data rows related to baltimore City

Balt <- subset(NEI, fips == "24510")

Balt$year <-factor(Balt$year)


## Create plot

png('plot3.png', width=600, height=480)

g <- ggplot(Balt, aes(x = year, y = Emissions, xlab = " Year"  , color = type, fill = type )) +
 geom_col() +
facet_wrap(~type)+
  ggtitle("Emissions by source type for Baltimore City")+
  labs( x = "Year", y = "Total Emissions (tonnes")+
  theme(legend.position = "none")

print(g)
dev.off()


