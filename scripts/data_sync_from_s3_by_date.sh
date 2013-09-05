#!/bin/bash

# Runs on dp4
# Syncs bismark data from s3 to dp4 for today and yesterday

# Exit on first error
set -e

# Blank file acting like a mutex
lock=(~/s3sync_by_date.lockfile)

# Open lockfile and name its file handle 200 (number chosen arbitarily)
exec 200>$lock

# If lock is already taken then exit
flock -n 200 || exit 1

# Rest of syncing code below
todays_date=$(date '+%Y%m%d')
yesterdays_date=$(date --date="yesterday" '+%Y%m%d')
root_dir='bismark_data_from_s3_by_date'

# Sync yesterdays folder for redundancy
s3cmd sync --skip-existing s3://bismark_data/tarballs_by_date/$yesterdays_date ~/$root_dir/$yesterdays_date
s3cmd sync --skip-existing s3://bismark_data/tarballs_by_date/$todays_date ~/$root_dir/$todays_date
~

