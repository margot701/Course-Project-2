NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
install.packages("dplyr")
install.packages("ggplot2")
library(dply)
library(ggplot2)
#filtering
#selection of SCC code for motor vehicule 
SCCvehicule <- SCC %>% filter(grepl("Vehicle",EI.Sector))
#Baltimore
NEItotal <- NEI  %>% filter(SCC%in%SCCvehicule$SCC & fips == "24510")
NEItotal <- NEItotal %>% group_by(year) %>%summarize(Total_emission=sum(Emissions))
#Los Angles
NEItotalCal <- NEI  %>% filter(SCC%in%SCCvehicule$SCC & fips == "06037")
NEItotalcal <- NEItotalCal %>% group_by(year) %>%summarize(Total_emission=sum(Emissions))
#both
NEItotalboth <- NEI  %>% group_by(year,fips) %>%filter(SCC%in%SCCvehicule$SCC & (fips == "06037"|fips == "24510")) %>% summarize(Total_emission=sum(Emissions)) %>% mutate(City=ifelse(fips=="06037","Los Angeles","Baltimore"))
#graph
A <- ggplot(NEItotal, aes(year, Total_emission))+ geom_line()+labs(title = "Motor vehicules Emission in Baltimore" )
B<- ggplot(NEItotalcal, aes(year, Total_emission))+ geom_line()+labs(title = "Motor vehicules Emission in Los Angeles" )
C <- ggplot(NEItotalboth, aes(year, Total_emission ,color=City, shape=City))+ geom_point()+geom_line()+labs(title = "Motor vehicules Emission in Baltimore vs Los Angeles")
#install.packages("cowplot")
library(cowplot)
plot_grid(A,B,C)

dev.copy(png,file="plot6.png")
dev.off()

