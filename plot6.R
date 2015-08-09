# check packages
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1]) 
if (is.installed('data.table') == 'FALSE') {install.packages("data.table")} else{library(data.table)}
if (is.installed('lubridate') == 'FALSE') {install.packages("lubridate")} else{library(lubridate)}
if (is.installed('ggplot2') == 'FALSE') {install.packages("ggplot2")} else{library(ggplot2)}


# set working directory
curdir <-setwd("D:/Google Drive/Coursera/Assignment 4.1/ExData_Plotting2")
file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(file.url,destfile=paste(curdir,'/exdata%2Fdata%2FNEI_data.zip',sep=""))
unzip(paste(curdir,'/exdata%2Fdata%2FNEI_data.zip',sep=""),exdir=paste(curdir,sep=""),overwrite=TRUE)

NEI  <- readRDS(paste(curdir,'/summarySCC_PM25.rds',sep=""))
SCC  <- readRDS(paste(curdir,'/Source_Classification_Code.rds',sep=""))

NEIveBaltimore <- vehiclesNEI[vehiclesNEI$fips == 24510,]
NEIveBaltimore$city <- "Baltimore City"
NEIveLA <- vehiclesNEI[vehiclesNEI$fips=="06037",]
NEIveLA$city <- "Los Angeles County, California"
NEIbothCity <- rbind(NEIveBaltimore,NEIveLA)

png(filename=paste(curdir,'/plot6.png',sep=""),width=480,height=480,units='px')
ggp <- ggplot(NEIbothCity, aes(x=factor(year), y=Emissions, fill=city)) +
 geom_bar(aes(fill=year),stat="identity") +
 facet_grid(scales="free", space="free", .~city) +
 guides(fill=FALSE) + theme_grey() +
 labs(x="year", y=expression("Total PM 2.5 Emission in Tons ")) + 
 labs(title=expression("Baltimore & LA PM 2.5 Motor Vehicle Source from 1999-2008"))

print(ggp)

graphics.off() 