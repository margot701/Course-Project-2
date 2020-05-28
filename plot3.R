NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
install.packages("dplyr")
install.packages("ggplot2")
library(dply)
library(ggplot2)
#filtering
NEItotal <- NEI %>% group_by(year,type)%>%filter(fips == "24510") %>%summarize(Total_emission=sum(Emissions))

# graph
ggplot(NEItotal,aes(year, Total_emission,color=type))+geom_smooth()+labs(title = "Type of Emission evolution in Baltimore")
dev.copy(png,file="plot3.png")
dev.off()

