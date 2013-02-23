#! /bin/bash

#This script tars all files in /bismark_data/data/ and puts them in /bismark_data/outbox/

tar_all_files()
{
	tar_name=/bismark_data/outbox/$1_$2_$(date '+%y%m%d_%H%M%S').tar
	find $3/ -mmin +5 -exec tar --remove-files -cvf $tar_name {} +
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
