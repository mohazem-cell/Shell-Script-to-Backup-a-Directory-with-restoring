#!/bin/bash

#initialize values of each parameters
dir=/home/mohamed-hazem/Desktop/OperatingSystem/Assigment_1/part1/sourceFile
backupdir=/home/mohamed-hazem/Desktop/OperatingSystem/Assigment_1/part1/CopyFile
max_backups=4

# Ensure both the source and backup directories exist
if [ ! -d "$dir" ] || [ ! -d "$backupdir" ]; then
    echo "Either the source directory or the backup directory doesn't exist."
	exit 1
fi

# Create the backup directory if it doesn't exist
if [ ! -d "$backupdir" ]; then
    mkdir -p "$backupdir"
fi

# Get current date in the format YYYY-MM-DD-HH-MM-SS
currentDate=$(date "+%Y-%m-%d-%H-%M-%S" )

# Backup source directory to backup directory with timestamp
cp -lr "$dir" "$backupdir/$currentDate"

# Count the number of backups
BackUp_count=$( ls -1 "$backupdir" | wc -l )

# If the number of backups exceeds the maximum, remove the oldest backups
if [  $BackUp_count -gt $max_backups  ]; then
    oldest_BackUp=$( ls -1 "$backupdir" | head -n 1 )
    rm -r "$backupdir/$oldest_BackUp"
fi

