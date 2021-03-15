# We are investigating the performance of RL1 machines
# This script produces the following:
# A list with the following components:
# 1. Character: Machine name ("RL1")
# 2. Vector:    (min, mean, max) utilization for the month (excluding unknown hours)
# 3. Logical:   Has utilization ever fallen below 90%? (TRUE/FALSE)
# 4. Vector:    All hours where utilization is unknown
# 5. Dataframe: For RL1 machines
# 6. Plot:      For all machines

util <- read.csv("C:/Users/hicko/Documents/R exercices/Advanced R/section_3/P3-Machine-Utilization.csv", stringsAsFactors = T)
head(util)
str(util)
nrow(util) #3600
summary(util)

#Create a Utilization column (utilization = 1 - Percent.Idle)
util$Utilization = 1 - util$Percent.Idle

#Change date-time format (POSIX)
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
util$Timestamp <- NULL
util <- util[,c(4,1,2,3)]
summary(util)

### Deliverable 1
### Character: Machine name ("RL1")
list_rl1 <- list(Machine="RL1")

### Deliverable 2
### Vector:    (min, mean, max) utilization for the month (excluding unknown hours)
util_stats_rl1 <- c(min(RL1$Utilization, na.rm=T),
                    mean(RL1$Utilization, na.rm=T),
                    max(RL1$Utilization, na.rm=T))
list_rl1$Stats <- util_stats_rl1

### Deliverable 3
#Logical:   Has utilization ever fallen below 90%?
util_under_90_flag <- util_stats_rl1[1] < 0.9
list_rl1$LowThreshold <- util_under_90_flag


### Deliverable 4
#Vector:    All hours where utilization is unknown
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

### Deliverable 5
### Dataframe: For RL1 machines
#Data related to RL1 machines
RL1 <- util[util$Machine == "RL1",]
list_rl1$Data <- RL1
list_rl1

### Deliverable 6
### Plot:      For all machines
#install.packages("ggplot2")
library(ggplot2)

p <- ggplot(data=util)

myplot <- p + geom_line(aes(x=PosixTime, y=Utilization, color=Machine), size=1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept=0.9, size=1.2, color="Gray", linetype=3)

list_rl1$Plot <- myplot
