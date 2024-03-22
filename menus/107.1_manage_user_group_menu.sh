#!/bin/bash

# GENERAL DATA

# By: Yannick Funes
# Datetime: 21/03/2023
# YT:

title="107.1 Manage User and Group Menu"
description="107.1 Manage user and group accounts and related system files with them."
machine=$(who am i | sed "s/^\(.*\)(\(.*\))\(.*\)/\2/" | sed "s/ //g")
date=$(date +%d/%m/%Y)
hour=$(date +%H:%M:%S)
server=$(logname)

# SHOWS

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
    echo "│          Main Menu            │"
    echo "├───────────────────────────────┤"
    echo "│ 1) Manage Users and Groups    │"
    echo "│ 2) Files Users and Groups     │"
    echo "│ 3) Exit                       │"
    echo "└───────────────────────────────┘"
}

# usar sed u otro para dividir el archivo shadows y obtener usuarios
show_manage_users_groups_1() {
    show_header

    echo "┌──────────────────────────────────┐"
    echo "│     Manage Users and Groups      │"
    echo "├──────────────────────────────────┤"
    echo "│ 1) Adding user accounts          │"
    echo "│ 2) Modification of User Accounts │"
    echo "│ 3) Deleting User Accounts        │"
    echo "│ 4) View Skel Directory           │"
    echo "│ 5) View login.defs file          │"
    echo "│ 6) Passwd (passwd) Command       │"
    echo "│ 7) The change (change) Commanda  │"
    echo "│ 8) Got to Main Menu              │"
    echo "│ 9) Exit                          │"
    echo "└──────────────────────────────────┘"
}

show_files_users_groups_2() {
    show_header

    echo "┌─────────────────────────────────────────┐"
    echo "│         Files Users and Groups          │"
    echo "├─────────────────────────────────────────┤"
    echo "│ 1) View passwd                          │"
    echo "│ 2) View group                           │"
    echo "│ 3) View shadow                          │"
    echo "│ 4) View gshadow                         │"
    echo "│ 5) Filter password and group databases  │"
    echo "│ 6) Got to Main Menu                     │"
    echo "│ 7) Exit                                 │"
    echo "└─────────────────────────────────────────┘"
}

# METHODS

get_input() {
    read -p "Choose your choice: " option
}

add_user_account() {
    read -p "Enter name account: " name
    while [ -z "$name" ]; do
        read -p "Enter name account: " name
    done

    read -p "Enter password: " password_account
    while [ -z "$password_account" ]; do
        read -p "Enter password: " password_account
    done

    read -p "Enter comment (optional): " comment
    read -p "Deactivation date (optional YYYY-MM-DD): " expiration_date
    read -p "Days after expiration (optional): " days_after_expiration

    useradd -p "$password_account" -c "$comment" -e "$expiration_date" -f "$days_after_expiration" "$name"

    clear
    show_manage_users_groups_1
    echo
    echo "=============================================================="

    if [ $(whoami) = "root" ]; then
        echo "User $(whoami)"
        id "$name"
        chage -l "$name"
    else
        id "$name"
        groups "$name"
        passwd -S "$name"
    fi
}

del_user_account() {
    read -p "Enter account name: " name
    userdel -r "$name"
    echo "User successfully remove ..."
}

# DISPLAYS

display_manage_users_groups() {
    while true; do
        show_manage_users_groups_1
        get_input
        echo
        echo "=============================================================="
        case $option in
        1) add_user_account ;;
        3) del_user_account ;;
        8) display_main ;;
        9)
            echo "Leaving the menu ..."
            clear
            exit
            ;;
        *)
            echo "Invalid option ..."
            ;;
        esac
        read -p "Press any key to continues ..."
    done
}

display_files_users_groups() {
    while true; do
        show_files_users_groups_2
        get_input
        echo
        echo "=============================================================="
        case $option in
        6) display_main ;;
        7)
            echo "Leaving the menu ..."
            clear
            exit
            ;;
        *)
            echo "Invalid option ..."
            ;;
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
        1) display_manage_users_groups ;;
        2) display_files_users_groups ;;
        3)
            echo "Leaving the menu ..."
            clear
            exit
            ;;
        *)
            echo "Invalid option ..."
            ;;
        esac
        read -p "Press any key to continues ..."
    done
}

# EXECUTE
display_main
