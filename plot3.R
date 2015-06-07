################################################################################
# SCRIPT DETAILS                                                               
#       Filename: PLOT3.R                                                
#       Author:   Rebecca Ziebell (rebecca.ziebell@gmail.com)
#       Purpose:  Generate plot 3 for Course Project 1 in Exploratory Data
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
# Create datetime variable for use in x axis.
#-------------------------------------------------------------------------------
hpc$dt <- paste(as.Date(hpc$Date, "%d/%m/%Y"), hpc$Time, sep=" ")
hpc$DateTime <- as.POSIXlt(hpc$dt)

#-------------------------------------------------------------------------------
# Reshape data set so sub_metering variables can be used as groups.                           
#-------------------------------------------------------------------------------
usePackage <- function(p) {
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}

usePackage("reshape2")

var_list <- paste("Sub_metering_", 1:3, sep="")

hpc_melt <- melt(hpc, id=c("DateTime"), measure.vars=var_list)

#-------------------------------------------------------------------------------
# Output line graph to PNG.              
#-------------------------------------------------------------------------------
png(file="./ExData_Plotting1/plot3.png", width=504, height=504, units='px',
    pointsize=12, bg="transparent", type="windows", family="sans")

col_list <- c("black", "red", "blue")

build_plot3 <- {
  with(hpc_melt, {
    plot(DateTime, value, type="n", ylab="Energy sub metering", xlab="")
    for(i in 1:3) {
      points(DateTime[variable == var_list[i]],
             value[variable == var_list[i]],
             type="l", col=col_list[i])
    }
    legend("topright", lwd="2", pch="", col=col_list, legend=var_list)
  })
}

build_plot3

dev.off()