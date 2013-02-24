#!/bin/bash

# Exit on first error
set -e

#runs on ec2
#This script tars all files in /bismark_data/data/ and puts them in /bismark_data/outbox/

tar_all_files()
{
	# We use '|' as the sed delimeter in tar --transform, so we must remove it
	# from filenames to prefix sed syntax errors.
	archive_dir=$(echo $1_$2_$(date '+%Y%m%d_%H%M%S') | sed 's/|/-/g')
	tar_name=/bismark_data/outbox/${archive_dir}.tar
	# When calling tar, use 'r' (append) instead of 'c' (create) because find
	# could call tar multiple times if there are too many filenames to pass.
	find $3/ -type f -mmin +5 -exec tar --remove-files --transform "s|.*/|$archive_dir/|" -rvf $tar_name {} +
	# Append mode doesn't work with zipped files, so we must zip afterward.
	[ -f $tar_name ] && gzip $tar_name
}


for experiment_name in /bismark_data/data/*
do
	for device_id in $experiment_name/*
	do
		e_name=$(basename $experiment_name)
		d_name=$(basename $device_id)
		tar_all_files $e_name $d_name $device_id
	done
done
