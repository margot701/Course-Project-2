NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
install.packages("dplyr")
install.packages("ggplot2")
library(dply)
library(ggplot2)
#filtering
#selection of SCC code for motor vehicule 
SCCvehicule <- SCC %>% filter(grepl("Vehicle",EI.Sector))

NEItotal <- NEI  %>% filter(SCC%in%SCCvehicule$SCC & fips == "24510")
NEItotal <- NEItotal %>% group_by(year) %>%summarize(Total_emission=sum(Emissions))

ggplot(NEItotal, aes(year, Total_emission))+ geom_line()+labs(title = "Motor vehicules Emission in Baltimore" )
dev.copy(png,file="plot5.png")
dev.off()

