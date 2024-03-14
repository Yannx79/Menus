#!/bin/bash

# Specify the directory to collect information from
directory="/var/log"

# Get information about the files in the directory
file_info=$(ls -l "$directory")

# Define the log file path
log_file="/root/logs/directory_info_$(date +%Y-%m-%d).log"

# Save the information to the log file
echo "Files Information in $directory:" >> "$log_file"
echo "$file_info" >> "$log_file"

echo "Data saved in $log_file"
