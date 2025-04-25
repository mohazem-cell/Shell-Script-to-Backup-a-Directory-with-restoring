#!/bin/bash

# Check if required arguments are provided
if [ $# -ne 2 ]; then
	echo "Usage: $0 <source_directory> <backup_directory>"
	exit 1
fi

# Function to restore the directory from a specified backup
restore_from_backup() {
	local backup_timestamp=$1
	echo "Restoring from backup: $backupdir/$backup_timestamp"
	# Clean the source directory
	rm -rf "$dir"/*
	# Copy the backup contents to the source directory
	cp -r "$backupdir/$backup_timestamp/"* "$dir"
}

# Get the source and backup directories
dir=$1
backupdir=$2

# Ensure both the source and backup directories exist
if [ ! -d "$dir" ] || [ ! -d "$backupdir" ]; then
	echo "Either the source directory or the backup directory doesn't exist."
	exit 1
fi

# Get all the backup directories sorted by timestamp
backups=($( ls -1 "$backupdir" | sort ))

# Find the current backup state (assume current state matches the most recent backup)
current_backup=""

# Infinite loop for navigating through backups
while true; do
	echo "Select an option:"
	echo "1. Restore to the previous backup"
	echo "2. Restore to the next backup"
	echo "3. Exit"
	read -p "Enter your choice: " choice

	# Get the index of the current backup
	current_index=-1
	for i in "${!backups[@]}"; do
		if [ "$current_backup" == "${backups[$i]}" ]; then
			current_index=$i
			break
		fi
	done

	case $choice in
	1)
		# Restore to the previous version
		if [ $current_index -gt 0 ]; then
			current_backup=${backups[$((current_index - 1))]}
			restore_from_backup "$current_backup"
			echo "Restored to a previous version: $current_backup"
		else
			echo "No older backup available to restore."
		fi
		;;
	2)
		# Restore to the next version
		if [ $current_index -lt $((${#backups[@]} - 1)) ]; then
			current_backup=${backups[$((current_index + 1))]}
			restore_from_backup "$current_backup"
			echo "Restored to a next version: $current_backup"
		else
			echo "No newer backup available to restore."
		fi
		;;
	3)
		# Exit the loop
		echo "Exiting..."
		break
		;;
	*)
		echo "Invalid choice. Please enter 1, 2, or 3."
		;;
	esac
done

