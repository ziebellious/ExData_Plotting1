################################################################################
# SCRIPT DETAILS                                                               
#       Filename: PLOT1.R                                                
#       Author:   Rebecca Ziebell (rebecca.ziebell@gmail.com)
#       Purpose:  Generate plot 1 for Course Project 1 in Exploratory Data
#                 Analysis session 15, Coursera
################################################################################

#-------------------------------------------------------------------------------
# Get column names from first line and store as vector.
#-------------------------------------------------------------------------------
hpc_cols <- unname(unlist(read.table("household_power_consumption.txt",
                                     head=FALSE, sep=";", nrows=1)))

#-------------------------------------------------------------------------------
# Read data for just February 1 & 2, 2007 (N.B. 2/1/2007 starts at line 66638, 
# and 2 days x 24 hours x 60 minute-level observations = 2880 rows.)
#-------------------------------------------------------------------------------
hpc <- read.table("household_power_consumption.txt", sep=";", 
                  col.names=hpc_cols, na.strings=c("?"), skip=66637, nrows=2880)

#-------------------------------------------------------------------------------
# Output histogram to PNG.              
#-------------------------------------------------------------------------------
png(file="./ExData_Plotting1/plot1.png", width=504, height=504, units='px',
    pointsize=12, bg="transparent", type="windows", family="sans")

with(hpc, hist(Global_active_power, col="Red", 
               xlab="Global Active Power (kilowatts)", 
               main="Global Active Power"))

dev.off()