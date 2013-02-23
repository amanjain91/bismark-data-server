#!/bin/bash

# Downloade and syncs bismark_data from s3 and puts it into ~/bismark_data_from_s3
# runs on dp4
s3cmd sync --skip-existing s3://bismark_data/tarballs/ ~/bismark_data_from_s3/
