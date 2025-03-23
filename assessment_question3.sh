#!/bin/bash -x
# -x in case of debugging

#======
# Author: Francis Matias
# Script: Management of users
#======

# Check if the scripts run as a root, as the enunciate referes to
check_root(){
    # If is in the root coninue, if not show error
    if  [[ $EUID -ne 0 ]]; then
        echo "ERROR: This script needs to run as sudo"
        exit 1
    fi  
}

# FUnction to validate file provided
check_file(){
    # Check if it is empty
    if  [[ -z "$1" ]]; then
        echo "Usage: $0 <user_list.txt>"
        exit 1
    fi

    # Check if it exists
    if [[ ! -f "$1" ]]; then
        echo "ERROR: Files does not exist"
        exit 1
    fi

    # Check if the file is empty
    if [[ ! -s "$1" ]]; then
        echo "ERROR: Files provided is empty"
        exit 1
    fi

}

# Function to create an user account
create_users(){
    INPUT_FILE="$1"
    # creating an array to store new users
    declare -a NEW_USERS

    echo -e "\n Starting user creation "$INPUT_FILE"\n"

    while IFS= read -r USERNAME; do
            echo "read line : '$USERNAME'"
        # problems with empty lines
        [[ -z "$USERNAME" ]] && continue

        # Check if user exists
        if id "$USERNAME" &>/dev/null; then
            echo "User '$USERNAME' already exists"
        # If do not exist
        else
            sudo useradd -m "$USERNAME"
            echo "User '$USERNAME' created!"
            # ADD to the array of new users
            NEW_USERS+=("$USERNAME")
        fi
    done < "$INPUT_FILE"

    echo -e "\n Created Users: ${NEW_USERS[*]}"
    # show the user
    awk -F: '$3 >= 1000 {print $1}' /etc/passwd

    echo -e "\n HOme Directory:"
    ls /home

    return 0
    

}

# Function to delete user accounts
delete_users(){
    INPUT_FILE="$1"
    echo -e "\n Deleting users '$INPUT_FILE\n"

    while IFS= read -r USERNAME; do

        # problems with empty lines
        [[ -z "$USERNAME" ]] && continue

        # Check if user exists
        if id "$USERNAME" &>/dev/null; then
            sudo deluser --remove-home "$USERNAME"
            echo "User '$USERNAME' deleted!"
        else
            echo "User '$USERNAME' does not exist"
        fi
    done < "$INPUT_FILE"

    # Show users
    echo -e "\n Users after deletion:"
    # show the user
    awk -F: '$3 >= 1000 {print $1}' /etc/passwd

    echo -e "\n HOme Directory:"
    ls /home


}

# RUns as root
check_root
# Validade the input
check_file "$1"
# Create the user list
create_users "$1"

# Ask if the user want to delete the accounts
read -p "Do you want to delete the accounts? (yes/no): " ANSWER

if [[ "$ANSWER" == "yes" ]]; then
    delete_users "$1"
    echo -e "\n All newly users have been deleted"
else
    echo -e "\n Keeping creating accounts"
fi