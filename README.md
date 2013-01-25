1. router to ec2: bismark-data-server receives data from routers running bismark-data-transmit on https://uploads.projectbismark.net:8081/upload/

2. ec2 to s3: bismark-data-server uploads this data to aws S3 where it is securely stored in bismark_data bucket

3. s3 to dp4: a cronjob needs to be run on dp4 which pulls data from S3 to dp4. The command is as follows:
*/10 * * * * s3cmd sync --skip-existing s3://bismark_data/ /home/bismark/var/data/http_uploads/
For this command to work, first the s3cmd package will have to be downloaded on dp4 and then it will have to be configured by the following:
s3cmd --configure


	
