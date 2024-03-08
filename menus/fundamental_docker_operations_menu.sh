#!/bin/bash
# By: Yannick Funes
# Datetime: 03/03/2024 23:31
# https://youtu.be/wIabEU8Zd1g

machine=`who am i | sed "s/^\(.*\)(\(.*\))\(.*\)/\2/" | sed "s/ //g"`
description="This script provides a user-interactive menu for a Linux system, allowing users to view information about images, networks, Docker processes, and volumes."
date=`date +%d/%m/%Y`
hour=`date +%H:%M:%S`
server=`logname`

show() {
    clear

    echo "=============================================================="
    echo "Machine   : $machine"
    # echo "Description   : $description"
    echo "Server    : $server"
    echo "Date      : $date"
    echo "Hour      : $hour"
    echo "=============================================================="
    echo ""

    echo "Main Menu"
    echo "1. Show Images"
    echo "2. Show Networks"
    echo "3. Show Docker Processes"
    echo "4. Show All Docker Processes" 
    echo "5. Show Volumes"
    echo "11. Exit"
}

get_input() {
    read -p "Choose your choice: " option
}

show_images() {
    docker images
}

show_networks() {
    docker network ls
}

show_docker_processes() {
    docker ps
}

show_all_docker_processes() {
    docker ps -a
}

show_volumes() {
    docker volume ls
}

while true; do
    show
    get_input

    echo
    echo "=============================================================="
    case $option in
        1) show_images;;
        2) show_networks;;
        3) show_docker_processes;;
        4) show_all_docker_processes;;
        5) show_volumes;;
        11) 
            echo "Leaving the menu ..."
            sleep 1
            clear
            exit;;
        *)
            echo "Invalid option";;
    esac

    read -p "Press any key to continues ..."

done
