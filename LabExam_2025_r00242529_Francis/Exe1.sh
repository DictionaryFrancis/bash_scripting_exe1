#!/bin/bash -x

# process the file
ps -ef > processes.txt

# using awk will extract the process that we want
awk '$1 == "root" { print $1, $2, $8 }' processes.txt > processes_root.txt

# and here from the users
awk -v user="$USER" '$1 == user { print $1, $2, $3 , $5, $8 }'  processes.txt > processes_user.txt

# open the menu
while true; do
    echo "\n === MENU === "
    echo "r. Output the process with PID values"
    echo "u. Show the last 18 entries from the extracted logged"
    echo "e. Exit menu"
    echo "Choose an option: "
    read option

    if [ "$option" = "r" ]; then
        echo "option r"
        if [ -s processes_root.txt  ]; then
            awk '$2 >= 8 && $2 <=64 { print $0 }' processes_root.txt
        else
            echo "The file is empty..."
        fi

    elif [ "$option" = "u" ]; then
        echo "option u"
        if [ -s processes_user.txt ]; then
            tail -n 18 processes_user.txt
        else
            echo "The file is empty..."

        fi

    elif [ "$option" = "e" ]; then
        echo "option e"
        echo "Exit script"
        break
    else 
        echo "Option invalid, please insert the correct one"
    fi

done