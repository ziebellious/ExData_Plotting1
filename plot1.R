################################################################################
# SCRIPT DETAILS                                                               
#       Filename: PLOT1.R                                                
#       Author:   Rebecca Ziebell (rebecca.ziebell@gmail.com)
#       Purpose:  Generate plot 1 for Course Project 1 in Coursera Exploratory 
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

hpc_cols <- unname(unlist(read.table(unz(temp, 
                                         "household_power_consumption.txt"),
                                     head=FALSE, sep=";", nrows=1)))

hpc <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",
                  col.names=hpc_cols, na.strings=c("?"), skip=66637, nrows=2880)

unlink(temp)

#-------------------------------------------------------------------------------
# Output histogram to PNG.              
#-------------------------------------------------------------------------------
png(file="plot1.png", width=504, height=504, units='px', pointsize=12,
    bg="transparent", type="windows", family="sans")

with(hpc, hist(Global_active_power, col="Red", 
               xlab="Global Active Power (kilowatts)", 
               main="Global Active Power"))

dev.off()

#-------------------------------------------------------------------------------
# Clean up workspace.
#-------------------------------------------------------------------------------
rm(list = ls())