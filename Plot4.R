### Load DPLYR package and ggplot packages

library(dplyr)
library(ggplot2)

##Read Source files from working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data to consider only coal sources

d1 <- SCC$EI.Sector

d1<- as.character(d1)
index <- grep("Coal", d1)

coaldat <- SCC[index,]

both <- intersect(NEI$SCC, coaldat$SCC)

subsetdat <- subset(NEI, NEI$SCC %in% coaldat$SCC)

y<- tapply(subsetdat$Emissions, subsetdat$year, sum)

##Create data frame of total emitted pollution and year

attributes(y) <- NULL

x<- c("1999", "2002", "2005", "2008")
x <- as.numeric(x)

df<- cbind(x,y)
df <- as.data.frame(df)
names(df) <- c("year", "total.pollutant")


### Plot data

png('plot4.png', width=600, height=480)
g <- ggplot(df, aes(factor(year), total.pollutant)) + geom_bar(stat="identity")+
  xlab("year") +
  ylab("Coal Combustion Sources PM2.5 Total Emissions") +
  ggtitle("Total Coal Combustion Sources PM2.5 Emissions Across US")

print(g)
dev.off()
