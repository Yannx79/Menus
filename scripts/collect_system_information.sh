#!/bin/bash

# Get system information
system_info=$(uname -a)
disk_info=$(df -h)
cpu_info=$(lscpu)
memory_info=$(free -m)

# Define the log file path
log_file="/root/logs/system_info_$(date +%Y-%m-%d).log"

# Save the information to the log file
echo "System Information:" >> "$log_file"
echo "$system_info" >> "$log_file"
echo -e "\nDisk Information:" >> "$log_file"
echo "$disk_info" >> "$log_file"
echo -e "\nCPU Information:" >> "$log_file"
echo "$cpu_info" >> "$log_file"
echo -e "\nMemory Information:" >> "$log_file"
echo "$memory_info" >> "$log_file"

echo "Data saved in $log_file"
