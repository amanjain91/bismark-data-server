#!/bin/bash

for file in $(find /bismark_data/outbox -name *.tar -mmin +5)
do
	base_filename=$(basename $file)
	experiment_name=$(echo $base_filename | cut -d'_' -f1)
	device_name=$(echo $base_filename | cut -d'_' -f2)
	from=$file
	to=s3://bismark_data/tarballs/$experiment_name/$device_name/$base_filename
	s3cmd -v put $from $to
	mv $file /bismark_data/uploaded/$base_filename
done
