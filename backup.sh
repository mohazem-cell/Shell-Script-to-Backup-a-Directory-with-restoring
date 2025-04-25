#!/bin/bash


#to check if the inputs is less than 4 parameters print this code
if [ $# -lt 4 ] 
then
	echo "Please renter in according to this shape"
	echo
	echo "backup_1.sh dir backupdir interval-secs max-backups"
fi

#initialize values of each parameters
dir=$1
backupdir=$2
interval_secs=$3
max_backups=$4

# Ensure both the source and backup directories exist
#if [ ! -d "$dir" ] || [ ! -d "$backupdir" ]; then
#    echo "Either the source directory or the backup directory doesn't exist."
#    exit 1
#fi

#To initialize a backups directory if there is not a backup directory 
#Use mkdir -- create a new directory
mkdir -p "$backupdir"

#to get info or intial values and all data then save it in directory-info.last
ls -lr "$dir" > directory-info.last

#function to create timestamp
timestamp(){
	date +"%Y-%m-%d-%H-%M-%S"
}

#to loop every time in one folder waiting to any change in it we used while loop
while true; do
	# to make the program waite till time end and work again
	sleep "$interval_secs"
	
	#to get info of new data then save it in directory-info.new
	ls -lr "$dir" > directory-info.new
	
	if ! cmp -s directory-info.last directory-info.new; then
		BackUp_name=$(timestamp)
		BackUp_path="$backupdir/$BackUp_name"
		
		# to get all folders from source folder to backup file
		# We used cp to copy a file
		# -r is used to get in recursively each file and folder from source to backup file
		cp -r "$dir" "$BackUp_path"
		
		#to print in terminal if changes occur
    		echo "Backup created at $BackUp_path"
    		
    		# to update directory-info.last with the new state
    		# we use mv which is used to move or rename files and directories.
    		mv  directory-info.new directory-info.last
		
		#Here, we need to control the size of backups according to what is written in the terminal
		
		#{ls -1 "$backupdir"} first this command ls the files in the folder "$backupdir" using ls then make this listed files be listed one by one by using -1
		# | pipe used to collect the previous command and set it as output to the other command
		# wc -l is used to count the number of lines from the output
		# $(....) is used to get the number and then save it ti BackUp_count
		BackUp_count=$( ls -1 "$backupdir" | wc -l )
		
		if [ "$BackUp_count" -gt "$max_backups" ];then
			# List the contents of the "$backupdir" directory, one per line, sorted alphabetically.
			# Pipe the output to the 'head -n 1' command, which selects the first item in the list.
			# The first item, which is the oldest backup (assuming the backups are named with chronological order),
			# is then stored in the variable `oldest_BackUp`.
			oldest_BackUp=$(ls -1 "$backupdir" | head -n 1)
			rm -rf "$backupdir/$oldest_BackUp"
      			echo "Deleted oldest backup: $oldest_BackUp"
		fi
	else
		echo "No changes detected, no backup created."
  	fi
done


