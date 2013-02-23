#! /bin/bash
# untars all files in ~/bismark_data_from_s3 and puts them in ~/bismark_data_untared

for tar_file in $(find ~/bismark_data_from_s3 -name *.tar -mmin +5)
do
	tar -xvf $tar_file -C ~/bismark_data_untared/
done
