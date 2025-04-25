# Shell Script to Backup a Directory with restoring

This project provides an shell script of backup and restore system using bash scripts and a Makefile. The system is divided into two parts:

    - Part 1: Automated directory backup.
    - Part 2: Restoring backups.

The Makefile is used to facilitate the process of running the backup and restore scripts, ensuring necessary directories exist.

## Directory Structure
    .
    ├── Makefile                 # Automates backup and restore processes
    ├── part1
    │   ├── backupd.sh           # Backup script
    |   ├── sourceFile/          # source directory (dir)
    |   └── CopyFile/            # Copy directory (backup_dir)
    ├── part2
    │   ├── restore.sh           # Restore script
    │   └── restore/             # Restore directory (created by the Makefile)
    └── README.md                # This README file
## Prespectives
To ensure that the bash shell and make utility are installed on your system. On most Linux distributions, they should be installed by default. You can check by running:

    bash --version
    make --version

To Download bash in ubuntu use this command terminal:

    Sudo apt-get install bash

To Download make in ubuntu use this command in terminal:

    sudo apt install make
## Usage
### Running the backup shell
The backup shell automatically creates a backup of a specified directory at regular intervals. It stores backups in a destination folder with a timestamped folder name. 
    
1. Open the makefile
2. Update the following variables as needed:
    1. dir: The directory you want to back up.
    2. backupdir: The directory where backups will be stored.
    3. INTERVAL_SECS: The time interval (in seconds) between backups.
    4. MAX_BACKUPS: The maximum number of backup versions to retain.

To run the bakup.sh file write in terminal use this command:

    make backup
This will:
1. Check if backupdir exists and create it if necessary.
2. Run the backup process using the backup.sh located in the part1 folder. 

### Running the restore shell
The restore script allows you to restore the source directory to a previous backup version. You can
navigate through previous and future backup versions using the terminal prompts.
1. Ensure the dir and backupdir are correctly set in the Makefile.

To run the restore process, use the following command:

    make restore

This will:
1. Check if the RESTORE_DIR exists in part2, and create it if necessary.
2. Run the restore process using the restore.sh Shell located in the part2 folder.

## How It Works
### Backup Process (backup.sh)
1. The backup.sh script runs in the part1 directory and automatically backs up the source directory at regular intervals.
2. The backups are saved in the backupdir with subdirectories named using the current timestamp (in the format YYYY-MM-DD-HH-MM-SS).
3. The script checks if the directory has changed by comparing the current state of the directory with the previous one using ls -lR command. If any changes are detected, a new backup is created.

### Restore Process (restore.sh)
1. The restore.sh script located in part2 allows you to restore the source directory to a specific version.
2. It prompts the user to either restore to the previous backup, move forward to the next available backup, or exit the process.

## How to use
1. Set dir and backupdir: 
    
    Edit the Makefile and set paths for the directory you want to back up and where you want to store backups:
    
        dir := ./part1/sourceFile
        backupdir := ./part1/CopyFile
2. Run the Backup shell:

    Use this command:
    
        make backup
    
    This will back up the ./part1/sourceFile folder into ./part1/CopyFile at regular intervals
3. Run the restore shell: 

    Use this command:

        make restore

    this will allow you to restore /home/user/my_project from backups in /home/user/backups. 

# Cron Job update in backup system
This project provides a backup system that runs as a cron job to automatically backup a specified directory every minute.

## Prerequisites

Before setting up the cron job, ensure the following requirements are met:

1. **Cron Service**: 

    - Ensure that the cron service is running. You can check the status of cron using the following     command:
        
           sudo systemctl status cron
    - If it is not running, start it using:
        
            sudo systemctl start cron
            sudo systemctl enable cron
2. **Executable Permissions**:
    
    Ensure that the backup-cron.sh file has executable permissions by running:
    
        chmod +x /path/to/backup_cron.sh

3. **Configure Paths**:
    
    Update the backup-cron.sh file to include the correct source and backup directory paths.    

## Step-by-step Setup Instructions
Follow these steps to configure the cron job:
### Step 1: Create the Backup Script
Create a script named backup_cron.sh with the content provided in the repository.
### Step 2: Set up the Cron Job
1. Open the crontab editor using the following command:
    
        crontab -e

2. Add the following line to the crontab file to schedule the backup job every minute at the 23rd second:

        23 * * * * /path/to/backup-cron.sh
3. Save and exit the crontab editor. The job will be installed automatically by cron.

### step 3:Verify the Cron Job
- To verify if the cron job is scheduled correctly, you can list your current cron jobs by running:
    
        crontab -l
- You should see the following entry:

        23 * * * * /path/to/backup-cron.sh
### Step 4: Check Cron Logs
To check if your cron job is running correctly, you can inspect the cron logs:

        grep CRON /var/log/syslog

## Cron Expression for Running Every 3rd Friday of the Month at 12:31 AM
If you want the backup to run every 3rd Friday of the month at 12:31 AM, you can use the following cron expression:

        31 0 * * 5 [ "$(date +\%d)" -ge 15 ] && [ "$(date +\%d)" -le 21 ] && /path/to/backup-cron.sh

## Note:
- Ensure you have updated the script paths in the cron job.
- Be careful when editing cron jobs to avoid syntax errors. Always verify your cron job with crontab -l.
- 31 0 * * 5: Runs at 12:31 AM on Fridays (5 represents Friday in cron).
- The $(date +\%d) ensures the job only runs between the 15th and 21st of the month (the typical range for the 3rd Friday).
