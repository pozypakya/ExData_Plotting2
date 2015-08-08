# check packages
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1]) 
if (is.installed('data.table') == 'FALSE') {install.packages("data.table")} else{library(data.table)}
if (is.installed('lubridate') == 'FALSE') {install.packages("lubridate")} else{library(lubridate)}

# set working directory
curdir <-setwd("D:/Google Drive/Coursera/Assignment 4.1/ExData_Plotting2")
file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(file.url,destfile=paste(curdir,'/exdata%2Fdata%2FNEI_data.zip',sep=""))
unzip(paste(curdir,'/exdata%2Fdata%2FNEI_data.zip',sep=""),exdir=paste(curdir,sep=""),overwrite=TRUE)

NEI  <- readRDS(paste(curdir,'/summarySCC_PM25.rds',sep=""))
SCC  <- readRDS(paste(curdir,'/Source_Classification_Code.rds',sep=""))

NEIBaltiMor <- NEI[NEI$fips=="24510",]
BaltimoreAgg <- aggregate(Emissions ~ year, NEIBaltiMor,sum)
png(filename=paste(curdir,'/plot2.png',sep=""),width=480,height=480,units='px')
barplot(BaltimoreAgg$Emissions,names.arg=BaltimoreAgg$year,xlab="Year",ylab="PM2.5 Emissions in (Tons)",main="Total PM2.5 Emissions From Baltimore City")

graphics.off() 