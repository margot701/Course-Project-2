NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
install.packages("dplyr")
library(dply)
#total emmission calculation
NEItotal <- NEI %>% group_by(year) %>% filter(fips == "24510") %>%summarize(Total_emission=sum(Emissions))

# graph
plot(NEItotal$year,NEItotal$Total_emission,type="b",col="red",ylab= "Total Emission",xlab="years",main="Total Emission evolution (1999-2008)")
dev.copy(png,file="plot2.png")
dev.off()

