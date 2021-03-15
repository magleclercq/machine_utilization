# machine_utilization
Investigating machines utilization efficiency of a coal terminal

We have one month worth of data for all of the coal terminal machines. 
The
dataset shows what percentage of capacity for each machine was idle (unused) in any
given hour. 
The script renders a list with the following components:
1. Character: Machine name
2. Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
3. Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
4. Vector: All hours where utilisation is unknown (NA’s)
5. Dataframe: For this machine
6. Plot: For all machines

Here is a view of the plot representing machine utilization of all machines during that month:
