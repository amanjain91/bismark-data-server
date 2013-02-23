#! /bin/bash

# untars all files in ~/bismark_data_from_s3 and puts them in ~/bismark_data_untared.
# also moves the .tar versions to ~/bismark_data_backup
# runs on dp4

for tar_file in $(find ~/bismark_data_from_s3 -name *.tar -mmin +5)
do
	tar -xvf $tar_file -C ~/bismark_data_untared/
	base_filename=$(basename $tar_file)
	experiment_name=$(echo $base_filename | cut -d'_' -f1)
	device_name=$(echo $base_filename | cut -d'_' -f2)
	mkdir -p ~/bismark_data_backup/$experiment_name/$device_name/
	mv $tar_file ~/bismark_data_backup/$experiment_name/$device_name/
done
