#!/bin/bash

# Exit on first error
set -e

# untars all files in ~/bismark_data_from_s3 and puts them in ~/bismark_data_untarred.
# also moves the .tar versions to ~/bismark_data_backup
# runs on dp4

find ~/bismark_data_from_s3 -name "*.tar.gz" -mmin +5 -mmin -65 | while read -r tar_file; do
	experiment_name=$(basename $tar_file | cut -d'_' -f1)
	device_name=$(basename $tar_file | cut -d'_' -f2)
	datestamp=$(basename $tar_file | cut -d'_' -f3)

	mkdir -p ~/bismark_data_untarred/$experiment_name/$device_name/$datestamp
	# --strip-components=1 tells tar to remove 1 leading directory name, so
	# files will be extracted directly into the directory given by -C.
	tar --strip-components=1 -xzvf $tar_file -C ~/bismark_data_untarred/$experiment_name/$device_name/$datestamp

done
