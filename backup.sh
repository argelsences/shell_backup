#!/bin/sh

# Sample command to backup files
#tar -czvf /path/to/your/file/storage/filename.tar.gz -C /directory/root/of/your/files the_folder_you_want_to_backup

WEBHOME=/directory/root/of/your/files
WEBFOLDER=the_folder_you_want_to_backup
FILEBACKUPROOT=/path/to/your/storage/path/
WEBARCHIVENAME=file-$(date +%Y-%m-%d-%H:%M:%S).tar.gz
LOG=/path/to/log/directory/filename.log
DBUSER=db_username
DBNAME=db_name
DBPASS=db_password
DBBACKUPROOT=/path/to/your/db/storage/
DBARCHIVENAME=db-$(date +%Y-%m-%d-%H:%M:%S).sql.gz

# Create file backup root if not exist
if [ ! -d $FILEBACKUPROOT ]; then
    mkdir -p $FILEBACKUPROOT
fi

# web backup
tar -czvf $FILEBACKUPROOT/$WEBARCHIVENAME -C $WEBHOME $WEBFOLDER > $LOG

# pause here for 10 seconds before we backup database
sleep 10

# Sample command to backup DB
# mysqldump --user=db_username --password='db_password' db_name | gzip > /path/to/db/backup/storage/filename.sql.gz

# Create db backup root if not exist
if [ ! -d $DBBACKUPROOT ]; then
    mkdir -p $DBBACKUPROOT
fi

mysqldump --opt --single-transaction --user=$DBUSER --password=$DBPASS $DBNAME |  gzip > $DBBACKUPROOT/$DBARCHIVENAME
