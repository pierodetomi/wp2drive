#!/bin/bash
# WordPress Backup Script

# -----------------------------------------------------------
# Configuration parameters
# -----------------------------------------------------------
WP_INSTALL_DIR=[path_to_wp_installation]
DB_USER=[mysql_db_user]
DB_NAME=[wp_database_name]
DATEKEY=`date +%Y%m%d_%H%M%S`
DRIVE_BACKUPS_BASE_PATH=[your_google_drive_path_to_backups]
DRIVE_APP=[path_to_drive_executable]

# -----------------------------------------------------------
# Create directory for backup data
# -----------------------------------------------------------
DRIVE_TMP_PATH=$DRIVE_BACKUPS_BASE_PATH$DATEKEY
mkdir $DRIVE_TMP_PATH


# -----------------------------------------------------------
# Execute MySql dump for specified database
# -----------------------------------------------------------
DB_BACKUP_FILEPATH=$DRIVE_TMP_PATH/db.sql
mysqldump -u $DB_USER $DB_NAME > $DB_BACKUP_FILEPATH


# -----------------------------------------------------------
# Zip WP installation folder
# -----------------------------------------------------------
WPDIR_BACKUP_FILEPATH=$DRIVE_TMP_PATH/www.zip
zip -r $WPDIR_BACKUP_FILEPATH $WP_INSTALL_DIR


# -----------------------------------------------------------
# Upload file to Google Drive
# -----------------------------------------------------------
cd $DRIVE_TMP_PATH
$DRIVE_APP push -no-prompt


# -----------------------------------------------------------
# Remove temporary files
# -----------------------------------------------------------
rm $DB_BACKUP_FILEPATH
rm $WPDIR_BACKUP_FILEPATH
rm -rf $DRIVE_TMP_PATH