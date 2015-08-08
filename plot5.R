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

# Subset coal combustion related NEI data
combustionData <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalData <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
CombustionCoal <- (combustionData & coalData)
SCCcombustion <- SCC[CombustionCoal,]$SCC
NEIcombustion <- NEI[NEI$SCC %in% SCCcombustion,]

png(filename=paste(curdir,'/plot4.png',sep=""),width=1080,height=480,units='px')
ggp <- ggplot(NEIcombustion,aes(factor(year),Emissions/10^5)) +  geom_bar(stat="identity",fill="grey",width=0.75) + theme_bw() + guides(fill=FALSE) + labs(x="year", y=expression("Total PM 2.5 Emission in Tons")) + labs(title=expression("PM 2.5 Combustion of Coal Source Emissions in US from 1999 to 2008"))
print(ggp)

graphics.off() 