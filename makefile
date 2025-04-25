
# Variables for script arguments for part1 diectory
dir := ./part1/sourceFile      # Replace with actual path
backupdir := ./part1/CopyFile      # Replace with actual path
INTERVAL_SECS := 2                          # Time interval between backups (in seconds)
MAX_BACKUPS := 2                            # Maximum number of backups to keep
BACKUP_SHELL := ./part1/backup.sh          # Path to the backup script in part1 directory

# Variables for script arguments for part2 directory
restoredir:= ./part2/restoreFolder	#Replace with actual path
RESTORE_SHELL := ./part2/restore.sh	# Path to the Restore script in part2 directory



# Target to run the bash backup shell with provided arguments
backup: pre-build
# This target is responsible for running the backup code.
# It first calls the `pre-build` target, to ensure that the backup directory exists.
# After that, it proceeds to run the backup script with the specified arguments.
	
# Print a message to indicate that the backup script is being executed
	@echo "Running backup script from the part1 directory..."
# The bash command runs the backup script.
# $(BACKUP_SHELL) is the variable that holds the path to the backup.sh located in the part1 directory.
# $(dir) is the source directory that needs to be backed up.
# $(backupdir) is the destination directory where backups will be stored.
# $(INTERVAL_SECS) is the time interval (in seconds) between each backup check.
# $(MAX_BACKUPS) is the maximum number of backups that should be kept.
# The '@' symbol suppresses the echoing of the bash command itself.
	@bash $(BACKUP_SHELL) $(dir) $(backupdir) $(INTERVAL_SECS) $(MAX_BACKUPS)

# Target to run the restore shell with provided arguments
restore: pre-build-restore
# This target runs the restore process.
# Before running the restore script, it calls the `pre-build-restore` target to ensure
# that any necessary setup for restoring is done, such as verifying that the restore directory exists.

# Print a message to indicate that the restore script is being executed.
	@echo "Running restore script from the part2 directory..."
# The bash command runs the restore script.
# $(RESTORE_SHELL) is the variable that holds the path to the restore script located in the part2 directory.
# $(restoredir) is the directory where the contents will be restored.
# $(backupdir) is the directory where the backups are stored, used to locate the appropriate version.
# The '@' symbol suppresses the echoing of the bash command itself.
	@bash $(RESTORE_SHELL) $(restoredir) $(backupdir)
# The .PHONY declaration marks the following targets as phony, meaning they are not associated with any actual files.
# This ensures that these targets are always executed, even if a file with the same name as the target exists.
# Phony targets are typically used for actions or commands, like backup and restore, to avoid conflicts with files.
.PHONY: backup restore pre-build pre-build-restore
