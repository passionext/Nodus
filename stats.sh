#!/bin/bash

# Use the command /chmod +x stats.sh/ to make the file executable


### CPU Usage ###
# Shows a snapshot of the current system that is created through the usage of the /top/ command. The option -b is used to run in batch mode, while the option -n1 is used to run the command for one iteration and the exit. It gets the sum of the CPU usage by the user and the system.

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')


### RAM Usage ###
# Shows the total memory, available memory and used memory.

total_memory=$(free -m | awk 'NR==2 {printf "%.2f", $2/1024}')
available_memory=$(free -m | awk 'NR==2 {printf "%.2f", $7/1024}')
used_memory=$(awk "BEGIN {printf \"%.2f\", $total_memory - $available_memory}")


### Disk Usage ###
# Shows the total space, available space and percentage of used space. The --block-size option allows the control of the unit used to report the disk space, which in this case is bytes.

total_disk=$(df --block-size=1 | awk 'NR>1 {sum += $2} END {print sum / (1024*1024*1024)}')

free_disk=$(df --block-size=1 | awk 'NR>1 {sum += $4} END {print sum / (1024*1024*1024)}')

percentage_disk=$(df | awk 'NR>1 {sum += $5} END {print sum}')



# Print the final result in a JSON format.
echo "{\"cpu_usage\":\"${cpu_usage}%\", \
\"total_memory\":\"${total_memory} GB\", \
\"available_memory\":\"${available_memory} GB\", \
\"used_memory\":\"${used_memory} GB\", \
\"total_disk\":\"${total_disk} GB\", \
\"free_disk\":\"${free_disk} GB\", \
\"percentage_disk\":\"${percentage_disk}%\"}"



