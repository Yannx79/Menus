#!/bin/bash

# Get access logs
access_logs=$(cat /var/log/auth.log)

# Define the log file path
log_file="/root/logs/access_logs_$(date +%Y-%m-%d).log"

# Save the logs to the log file
echo "Access Logs:" >> "$log_file"
echo "$access_logs" >> "$log_file"

echo "Data saved in $log_file"
