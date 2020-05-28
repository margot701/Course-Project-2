NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
install.packages("dplyr")
install.packages("ggplot2")
library(dply)
library(ggplot2)
#filtering
#selection of SCC code for coal combustion 
SCCcoal <- SCC %>% filter(EI.Sector=="Fuel Comb - Electric Generation - Coal")
vect<- SCCcoal$SCC
vect
length(vect)
NEItotal <- NEI  %>% filter(SCC%in%SCCcoal$SCC)
NEItotal <- NEItotal %>% group_by(year) %>%summarize(Total_emission=sum(Emissions))

ggplot(NEItotal, aes(year, Total_emission))+ geom_line()+labs(title = "Coal combustion emission evolution in US" )
dev.copy(png,file="plot4.png")
dev.off()

