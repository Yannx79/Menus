#!/bin/bash

#!/bin/bash
# By: Yannick Funes
# Datetime: 07/03/2023
# https://youtu.be/GzsJT6ix-MI
# Script: /scripts/collect_file_information.sh*
# Script: /scripts/collect_system_information.sh*
# Script: /scripts/get_access_logs.sh*


title="Crontab Menu"
description="This script manages cron jobs on a Linux system. It provides a menu-driven interface for users to interact with cron tasks."  
machine=`who am i | sed "s/^\(.*\)(\(.*\))\(.*\)/\2/" | sed "s/ //g"`
date=`date +%d/%m/%Y`
hour=`date +%H:%M:%S`
server=`logname`

# GENERAL OPTIONS

# SHOW

show_header() {
    clear

    echo "=============================================================="
    echo "Title         : $title"
    # echo "Description   : $description"
    echo "Machine       : $machine"
    echo "Server        : $server"
    echo "Date          : $date"
    echo "Hour          : $hour"
    echo "=============================================================="
    echo
}

show_main() {
    show_header
    
    echo "┌───────────────────────────────┐"
    echo "│           Main Menu           │"
    echo "├───────────────────────────────┤"
    echo "│ 1) Display Crontab File       │"
    echo "│ 2) Remove Crontab File        │"
    echo "│ 3) Create Crontab File        │"
    echo "│ 4) Exit                       │"
    echo "└───────────────────────────────┘"
}

show_create() {
    show_header

    echo "┌───────────────────────────────┐"
    echo "│       Choose an Option        │"
    echo "├───────────────────────────────┤"
    echo "│ 1) Create crontab file        │"
    echo "│ 2) Show special string        │"
    echo "│ 3) Show crontab format        │"
    echo "│ 4) Go to Main Menu            │"
    echo "│ 5) Exit                       │"
    echo "└───────────────────────────────┘"
}

# OPERATIONS

show_crontab_format() {
    echo "Crontab Format:"
    echo "┌───────────── Crontab Format ──────────────┐"
    echo "│  *    *    *    *    *  command to be     │"
    echo "│  │    │    │    │    │  executed          │"
    echo "│  │    │    │    │    └─  Day of Week      │"
    echo "│  │    │    │    └──────  Month            │"
    echo "│  │    │    └───────────  Day of Month     │"
    echo "│  │    └────────────────  Hour             │"
    echo "│  └─────────────────────  Minute           │"
    echo "└───────────────────────────────────────────┘"
}


show_crontab_string() {
    echo "Special Strings:"
    echo "┌────────────── Special Strings ──────────────┐"
    echo "│  @reboot                                    │"
    echo "│  @yearly   (once a year at midnight Jan 1)  │"
    echo "│  @annually (same as @yearly)                │"
    echo "│  @monthly  (once a month at midnight)       │"
    echo "│  @weekly   (once a week at midnight on Sun) │"
    echo "│  @daily    (once a day at midnight)         │"
    echo "│  @midnight (same as @daily)                 │"
    echo "│  @hourly   (once an hour at the beginning   │"
    echo "│             of the hour)                    │"
    echo "└─────────────────────────────────────────────┘"
}

show_special_string() {
    echo "Special Strings:"
    echo "┌─────────────── Special Strings ────────────────┐"
    echo "│  1) @reboot                                    │"
    echo "│  2) @yearly   (once a year at midnight Jan 1)  │"
    echo "│  3) @annually (same as @yearly)                │"
    echo "│  4) @monthly  (once a month at midnight)       │"
    echo "│  5) @weekly   (once a week at midnight on Sun) │"
    echo "│  6) @daily    (once a day at midnight)         │"
    echo "│  7) @midnight (same as @daily)                 │"
    echo "│  8) @hourly   (once an hour at the beginning   │"
    echo "│                of the hour)                    │"
    echo "│  9) Go to Main Menu                            │"
    echo "│  10) Exit                                      │"
    echo "└────────────────────────────────────────────────┘"
}

display_crontab_file() {
    crontab -l
}

remove_crontab_ifle() {
    crontab -r
}

create_crontab_file() {
    is_special_string=""
    crontab_string=""
    c_command=""

    # Prompt user for special strings
    read -p "Enter special strings {yes/no} (no): " is_special_string

    # Set default value if input is empty
    if [ -z "$is_special_string" ]; then
        is_special_string="no"
    fi

    # If special strings are not selected, prompt for individual time values
    if [ "$is_special_string" == "no" ]; then
        read -p "Enter the minute (0..59): " c_min
        read -p "Enter the hour (0..23): " c_hour
        read -p "Enter the day of month (1..31): " c_day
        read -p "Enter the month (1..12): " c_mon
        read -p "Enter the day of week (0=Sun .. 6=Sat): " c_weekday

        # Construct crontab string with individual time values
        crontab_string="$c_min $c_hour $c_day $c_mon $c_weekday"

    else
        special_string=""

        # Prompt for special string
        display_special_string

        # Use selected special string
        crontab_string="$special_string"
    fi

    # Prompt for command or script path
    read -p "Enter the command or script path: " c_command

    # Append command or script path to crontab string
    crontab_string+=" $c_command"

    # Add crontab string to file
    echo "$crontab_string" >> file
    
    # Install crontab from the file
    crontab file
}

get_input() {
    read -p "Choose your choice: " option
}

# DISPLAY

display_special_string() {
    show_special_string
    get_input

    echo
    echo "=============================================================="
    case $option in
    1) special_string="@reboot";;
    2) special_string="@yearly";;
    3) special_string="@annually";;
    4) special_string="@monthly";;
    5) special_string="@weekly";;
    6) special_string="@daily";;
    7) special_string="@midnight";;
    8) special_string="@hourly";;
    9) display_main;;
    10)
        echo "Leaving the menu ..."
        sleep 1
        clear
        exit;;
    *) 
        echo "Invalid option ...";;
    esac
}

display_create() {
    while true; do
        show_create
        get_input

        echo
        echo "=============================================================="
        case $option in
        1) create_crontab_file;;
        2) show_crontab_string;;
        3) show_crontab_format;;
        4) display_main;;
        5)
            echo "Leaving the menu ..."
            sleep 1
            clear
            exit;;
        *) 
            echo "Invalid option ...";;
        esac

        read -p "Press any key to continues ..."
    done
}

display_main() {
    while true; do
        show_main
        get_input

        echo
        echo "=============================================================="
        case $option in
        1) display_crontab_file;;
        2) remove_crontab_ifle;;
        3) display_create;;
        4)
            echo "Leaving the menu ..."
            sleep 1
            clear
            exit;;
        *) 
            echo "Invalid option ...";;
        esac

        read -p "Press any key to continues ..."
    done
}

display_main
