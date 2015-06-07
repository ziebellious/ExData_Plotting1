################################################################################
# SCRIPT DETAILS                                                               
#       Filename: PLOT3.R                                                
#       Author:   Rebecca Ziebell (rebecca.ziebell@gmail.com)
#       Purpose:  Generate plot 3 for Course Project 1 in Coursera Exploratory 
#                 Data Analysis session 15
################################################################################

#-------------------------------------------------------------------------------
# Start with a fresh workspace.
#-------------------------------------------------------------------------------
rm(list = ls())

#-------------------------------------------------------------------------------
# Download source data into temp file from provided URL. Unzip and extract first
# row of data as column headers, then extract data for only February 1 & 2, 2007
# based on manual review of table. (01FEB2007 data begin at line 66638, and
# there are 2880 minutes in two days.)
#-------------------------------------------------------------------------------
temp <- tempfile()

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, temp)

hpc_cols <- unname(unlist(read.table(unz(temp, "household_power_consumption.txt"),
                                     head=FALSE, sep=";", nrows=1)))

hpc <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",
                  col.names=hpc_cols, na.strings=c("?"), skip=66637, nrows=2880)

unlink(temp)

#-------------------------------------------------------------------------------
# Create datetime variable for use in x axis of plot.
#-------------------------------------------------------------------------------
hpc$dt <- as.POSIXct(paste(as.Date(hpc$Date, "%d/%m/%Y"), hpc$Time, sep=" "))

#-------------------------------------------------------------------------------
# Reshape data to put all sub-metering data in a single column.
#-------------------------------------------------------------------------------
usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}

usePackage("reshape2")

var_list <- paste("Sub_metering_", 1:3, sep="")

hpc_melt <- melt(hpc, id=c("dt"), measure.vars=var_list)

#-------------------------------------------------------------------------------
# Output line graph to PNG.              
#-------------------------------------------------------------------------------
png(file="plot3.png", width=504, height=504, units='px',
    pointsize=12, bg="transparent", type="windows", family="sans")

color_list <- c("black", "red", "blue")

build_plot3 <- {
  with(hpc_melt, {
    plot(dt, value, type="n", ylab="Energy sub metering", xlab="")
    for(i in 1:3) {
      points(dt[variable == var_list[i]],
             value[variable == var_list[i]],
             type="l", col=color_list[i])
    }
    legend("topright", lwd="2", pch="", col=color_list, legend=var_list)
  })
}

build_plot3

dev.off()

#-------------------------------------------------------------------------------
# Clean up workspace.
#-------------------------------------------------------------------------------
rm(list = ls())