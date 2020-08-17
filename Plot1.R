### Load DPLYR package

library(dplyr)


##Read Source files from working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset data by year

y<- tapply(NEI$Emissions, NEI$year, sum)

##Create data frame of total emitted pollution and year

attributes(y) <- NULL

x<- c("1999", "2002", "2005", "2008")
x <- as.numeric(x)

df<- cbind(x,y)
df <- as.data.frame(df)
names(df) <- c("year", "total.pollutant")

## add new column to df to scale data to make plot scale more readable

df <- df%>% mutate(new.pollutant = total.pollutant/ 1000000)

### Plot data

png('plot1.png', width=600, height=480)

with(df, plot(df$year, df$new.pollutant, main = "Change in national PM2.5 over time", type = "b",
              pch = 19, col = "red", xlab = "Year", ylab = "Total Pollution (million tonnes)"))

dev.off()


