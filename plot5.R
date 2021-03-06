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

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCCvehicles <- SCC[vehicles,]$SCC
NEIvehicles <- NEI[NEI$SCC %in% SCCvehicles,]

baltimoreNEIvehicles <- NEIvehicles[NEIvehicles$fips==24510,]
png(filename=paste(curdir,'/plot5.png',sep=""),width=480,height=480,units='px')
ggp <- ggplot(baltimoreNEIvehicles,aes(factor(year),Emissions)) + geom_bar(stat="identity",fill="grey",width=0.75) +  theme_bw() +  guides(fill=FALSE) +  labs(x="year", y=expression("Total PM2.5 Emission in Tons")) +   labs(title=expression("Baltimore PM 2.5 Motor Vehicle Source from 1999-2008"))

print(ggp)

graphics.off() 