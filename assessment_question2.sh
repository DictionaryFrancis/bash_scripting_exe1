#!/bin/bash 
# -x in case of debugging

#======
# Author: Francis Matias
# Script: Interactive bash script menu
#======

# Check if the file exists
check_file(){
    if [[ ! -f "$1" ]]; then
        echo "ERROR: File does not exist"
        return 1 # Similiar as exit 1
    fi
    return 0 # Similiar as exit 0
}

# Menu quantity
quantity_menu(){
    # Can change the file path
    FILE="/home/student/SystemScripting/assessment1/grub.txt"
    # Using the funciotn to validate the file
    check_file "$FILE" || return

    # Counting how many times the word "LINUX"
    WORD_LINUX=$(grep -o "Linux" "$FILE" | wc -l)
    echo "\n The word Linux was written $WORD_LINUX times in the $FILE"

    # Couting how many lines contain Linux
    echo "\n Lines containing Linux:"
    grep "Linux" "$FILE"

    # Couting empty lines
    EMPTY_LINES=$(grep -c "^$" "$FILE") #"^$" to check empty lines
    echo "\n Lines emptty: $EMPTY_LINES"

    # Lines starting with '#' adding in a new file
    FILE_HASHTAG="hashtag.txt"
    grep "^#" "$FILE" > "$FILE_HASHTAG"

    # Showing file hashtag
    echo -e "\n Comments saved in '$FILE_HASHTAG':"
    cat "$FILE_HASHTAG"

    echo -e "\n Return to Menu"
}


# Function details
details_menu(){
    # Can change the file path
    FILE="/home/student/SystemScripting/assessment1/ufw.txt"

    # Using the funciotn to validate the file
    check_file "$FILE" || return

    # Words starting with l and ending with y
    echo -e "\n Words starting with l and ending with y:"
    grep -E '\bl[a-z]*y\b' "$FILE"

    # Lines starting with upper D
    STARTING_WITH_D=$(grep -c "^D" "$FILE")
    echo -e "\n Lines starting with D: $STARTING_WITH_D"

    # File into the array
    lenght_array=()
    I=0
    
    while IFS= read -r LINE; do
        lenght_array[$I]="$LINE"
        ((I++))
    done < "$FILE"
    DISPLAY_ARRAY=${#lenght_array[@]}
    echo -e "\n Total lines in the file: $DISPLAY_ARRAY"

    # Lines with odd numbers
    echo -e "\n Lines with odd numbers:"
    for ((i = 1; i < lenght_array; i += 2)); do
        echo "${DISPLAY_ARRAY[i]}"
    done

    echo -e "\n Return to Menu"
    

}


# FUnction to write to a file
write_to_file(){
    # User insert the filename
    read -p "Enter the file name: " FILE_NAME

    # If the file does not exist we create it
    touch "$FILE_NAME"

    # Ask the user to start the inputs
    echo "Start thw write. Type 'done' to stop"
    while true; do
        read -r LINE
        if [[ "$LINE" == "done" ]]; then
            break
        fi
        echo "$LINE" >> "$FILE_NAME"
    done

    echo -e "\n Content of the document $FILE_NAME:"
    cat "$FILE_NAME"

    echo -e "\n Return to Menu"

}


# Exit the menu
exit_menu(){
    echo -e "\n Goodbye my friend"
    exit 0
}


# Menu
while true; do
    echo -e "\n === MENU === "
    echo "1. Quantity"
    echo "2. Details"
    echo "3. Write to a file"
    echo "4. Exit menu"
    read -p "Choose an option between 1-4: " CHOOSE

    case "$CHOOSE" in
        1) quantity_menu ;;
        2) details_menu ;;
        3) write_to_file ;;
        4) exit_menu ;;
        *) echo "This option doesn't exist, try again my friend" ;;
    esac

done