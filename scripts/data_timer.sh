#!/bin/bash

set -e
todays_date=$(date '+%Y%m%d')
current_timestamp=$(date '+%s')
for device_id in /bismark_data/uploaded/active/*
do
	dir=$device_id/$todays_date
	if [ -d "$dir" ]; then
		#echo $dir
		tarfile=$(ls -t $dir | awk 'NR==1{print $1}')
		#echo $tarfile
		line=$(tar -ztf $dir/$tarfile | awk 'NR==1{print $1}')
		#echo $line
		timestamp=$(echo $line | awk -F/ '{print $NF}' | awk -F_ '{print $NF}' | awk -F. '{print $1}')
		time_diff=$(expr $current_timestamp - $timestamp)
		#echo 'issue: ' $device_id $timestamp $current_timestamp $time_diff
		if [ "$time_diff" -gt 172800 ]; then
			echo 'issue: ' $device_id $timestamp $current_timestamp $time_diff $todays_date $line
		fi
	fi
done
