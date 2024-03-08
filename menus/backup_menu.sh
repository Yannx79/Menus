#!/bin/bash

#!/bin/bash
# By: Yannick Funes
# Datetime: 07/03/2023
# 

title="Backup Menu"
description="This script provides a basic structure for a Bash menu program for backup operations."  
machine=`who am i | sed "s/^\(.*\)(\(.*\))\(.*\)/\2/" | sed "s/ //g"`
date=`date +%d/%m/%Y`
hour=`date +%H:%M:%S`
server=`logname`

# GENERAL OPTIONS

show() {
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

    echo "1) Full Backup"
    echo "2) Incremental Backup"
    echo "3) Automatic Programming"
    echo "4) Custom Directory Selection"
    echo "5) Email Notifications"
    echo "6) Backup Rotation"
    echo "7) Activity Register"
    echo "8) Integrity Verification"
    echo "9) External or Cloud Storage"
    echo "10) Restoring Backups"
    echo "11) Exit"
}

get_input() {
    read -p "Choose your choice: " opton
}

display() {
    while true; do
        show
        get_input

        echo
        echo "=============================================================="
        case $option in
            1) exec_full_backup;;
            2) exec_incremental_backup;;
            3) exec_automatic_programming;;
            4) exec_custom_directory_selection;;
            5) exec_email_notifications;;
            6) exec_backup_rotation;;
            7) exec_activity_register;;
            8) exec_integrity_verification;;
            9) exec_external_or_cloud_storage;;
            10) exec_restoring_backup;;
            11) 
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

# METHODS 

exec_full_backup() {

}

exec_incremental_backup() {

}

exec_automatic_programming() {
    
}

exec_custom_directory_selection() {
    
}

exec_email_notifications() {
    
}

exec_backup_rotation() {
    
}

exec_activity_register() {
    
}

exec_integrity_verification() {
    
}

exec_external_or_cloud_storage() {
    
}

exec_restoring_backup() {
    
}

echo "1) Full Backup"
    echo "2) Incremental Backup"
    echo "3) Automatic Programming"
    echo "4) Custom Directory Selection"
    echo "5) Email Notifications"
    echo "6) Backup Rotation"
    echo "7) Activity Register"
    echo "8) Integrity Verification"
    echo "9) External or Cloud Storage"
    echo "10) Restoring Backups"
    echo "11) Exit"

# START MENU

display
