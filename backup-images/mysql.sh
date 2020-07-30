#!/bin/bash
#Verify required variables are set.
if [ -z "${AWS_KEY}" ]; then
    echo "ERROR: The environment variable key is not set."
    exit 1
fi

if [ -z "${AWS_SECRET}" ]; then
    echo "ERROR: The environment variable secret is not set."
    exit 1
fi

#Replace values in s3cfg

echo "access_key=${AWS_KEY}" >> /root/.s3cfg
echo "secret_key=${AWS_SECRET}" >> /root/.s3cfg


#Script to create mysql backup

TSTAMP=$(date +"%d-%b-%Y-%H-%M-%S")
LOG_FILE=/backup/logs
BACKUP_LOCATION=/backup/mysql/$TSTAMP
DB_PASSWORD=root
DB_USERNAME=root
S3_BUCKET="s3://some-bucket-name/mysql"

#Check log directory exists
if [ -d $LOG_FILE ]; then
	echo "INFO: Log directory exists."
else
	mkdir -p $LOG_FILE
fi

#Check backup location exists.
if [ -d $BACKUP_LOCATION ]; then
        echo "INFO: Backup directory exists."
else
        mkdir -p $BACKUP_LOCATION
	echo "INFO: Backup directory created: $BACKUP_LOCATION"
fi


#Database list
DB_LIST=( database1 database2 database3 )


echo "$TSTAMP: Starting mysql backup" >> "$LOG_FILE/mysql-backup.log"
for i in ${DB_LIST[@]}; do
	mysqldump -h mysql -u $DB_USERNAME -p$DB_PASSWORD ${i} | gzip > $BACKUP_LOCATION/${i}_$TSTAMP.sql.gz
        echo "$TSTAMP: Backup of database ${i} has been completed" >> "$LOG_FILE/mysql-backup.log"

done


#Uploading files to s3
echo "$TSTAMP: Files uploadng to s3 started" >> "$LOG_FILE/mysql-backup.log"
s3cmd put --recursive $BACKUP_LOCATION $S3_BUCKET/
echo "$TSTAMP: Files are uploaded successfully" >> "$LOG_FILE/mysql-backup.log"
