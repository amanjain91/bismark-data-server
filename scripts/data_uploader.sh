#!/bin/bash

# Exit on first error
set -e

#This script uploads all files in /bismark_data/outbox to s3 and also moves the files to /bismark_data/uploaded
#runs on ec2

find /bismark_data/outbox -name "*.tar.gz" -mmin +5 | while read -r file; do
	base_filename=$(basename $file)
	experiment_name=$(echo $base_filename | cut -d'_' -f1)
	device_name=$(echo $base_filename | cut -d'_' -f2)
	datestamp=$(echo $base_filename | cut -d'_' -f3)
	from=$file
	to=s3://bismark_data/tarballs/$experiment_name/$device_name/$datestamp/$base_filename
	s3cmd -v put $from $to
	mv $file /bismark_data/uploaded/$base_filename
done
