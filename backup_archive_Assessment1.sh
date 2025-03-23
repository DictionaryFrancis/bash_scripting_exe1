#!/bin/bash -x
# -x in case of debugging

#======
# Author: Francis Matias
# Script: Backup_archive
#======


# Check if the folder exists (Validation)
if [[ -z "$1" ]]; then  # CHeck if it is empty
    echo "Usage: $0 <folder-path>" # if wrong shows how to use it
    exit 1 # If no arguments if filled, the error show up
fi

# Variable for the folder
FOLDER="$1"
echo "DEGUB: Checking $FOLDER"

# Validade if the folder exist in the system
if [[ ! -d "$FOLDER" ]]; then  # CHeck if it is a directory
    echo "ERROR: Folder does not exist" # if its not, shows the error
    exit 1 
fi

# Array that will store the renamed file
declare -a RENAMED_FILES

# keep track of the renamed files
a=1 #counting it
# Loop that check all the .jpg files inside the folder
for FILE in "$FOLDER"/*.jpg; do
    if [[ $a -le 10 ]]; then # only the 10 first images
        NEW_NAME=$(printf "sun-foto-%02d.jpg" "$a") # use printf to format the string
        mv "$FILE" "$FOLDER/$NEW_NAME" # Using mv to rename the file
        RENAMED_FILES+=("$NEW_NAME") # And storing in hte array declared
        ((a++)) #Incrementing
    else
        break
    fi
done

# Loop counter, where it goes initialize
I=0
# Check the number of elem in the arrau, and used until to runs
# until the condition becomes true
until [[ $I -ge ${#RENAMED_FILES[@]} ]]; do

    FILE_NAME="${RENAMED_FILES[$I]}" # take the current file name from the array
    FILE_PATH="$FOLDER/$FILE_NAME" # make the path of the file

    OWNER=$(ls -l "$FILE_PATH" |awk '{print $3}') # List the file path and check the owner using awk
    SIZE=$(stat -c "%s" "$FILE_PATH") # CHeck the Size to show up in the echo

    # SHow the details
    echo "FILE: $FILE_NAME - OWNED: $OWNER - SIZE: $SIZE in bytes"

    ((I++)) # Incrementing


done

# Create variable for the backup file
BACKUP="$FOLDER/backup"
mkdir -p "$BACKUP" # create the folder with mkdir
mv "$FOLDER"/sun-foto-*.jpg "$BACKUP" #move the renamed files to the new backup folder
# Creating a compressed archive
BACKUP_ARCHIVE="$HOME/sun-foto-backup.tar.gz"
# here we compress using zip file and ensure the backup to the file backup
tar -czf "$BACKUP_ARCHIVE" -C "$FOLDER" backup

# Listing the archives that was saved
echo -e "Backup archive created in: $BACKUP_ARCHIVE"
ls -l "$HOME"