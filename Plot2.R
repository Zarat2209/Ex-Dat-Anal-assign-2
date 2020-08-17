### Load DPLYR package

library(dplyr)


##Read Source files from working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset Data to consider only data rows related to Baltimore City

Balt <- subset(NEI, fips == "24510")

y<- tapply(Balt$Emissions, Balt$year, sum)

##Create data frame of total emitted pollution and year

attributes(y) <- NULL

x<- c("1999", "2002", "2005", "2008")
x <- as.numeric(x)

df<- cbind(x,y)
df <- as.data.frame(df)
names(df) <- c("year", "total.pollutant")

### Plot data

png('plot2.png', width=600, height=480)

with(df, plot(df$year, df$total.pollutant, main = "Change in PM2.5 over time for Baltimore City", type = "b",
              pch = 19, col = "blue", xlab = "Year", ylab = "Total Pollution (tonnes)"))

dev.off()

