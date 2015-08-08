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

NEIBaltiMor <- NEI[NEI$fips=="24510",]
png(filename=paste(curdir,'/plot3.png',sep=""),width=1080,height=480,units='px')
ggp <- ggplot(NEIBaltiMor,aes(factor(year),Emissions,fill=type)) +  geom_bar(stat="identity") +  theme_bw() + guides(fill=FALSE)+
facet_grid(.~type,scales = "free",space="free") + labs(x="year", y=expression("Total PM 2.5 Emission (Tons)")) + labs(title=expression("PM 2.5 Emissions, Baltimore City 1999-2008 by Source Type"))
print(ggp)

graphics.off() 