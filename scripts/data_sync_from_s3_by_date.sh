#!/bin/bash

# Exit on first error
set -e

#runs on dp3
#syncs bismark data from s3 to dp4 for today and yesterday

todays_date=$(date '+%Y%m%d')
yesterdays_date=$(date --date="yesterday" '+%Y%m%d')
root_dir='bismark_data_from_s3_by_date'

s3cmd sync --skip-existing s3://bismark_data/tarballs_by_date/$yesterdays_date ~/$root_dir
s3cmd sync --skip-existing s3://bismark_data/tarballs_by_date/$todays_date ~/$root_dir
