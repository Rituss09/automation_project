sudo apt update -y
name='ritu'
s3_bucket='upgrad-ritu'
ts=$(date '+%d%m%Y-%H%M%S')

apinstalled=$(dpkg --get-selections apache2 |awk '{print $1}')

apactive=$(sudo systemctl status apache2 | grep "active" | awk '{print $2}')

apenable=$(sudo systemctl is-enabled apache2)

if [ "$apinstalled"= "apache2" ]
then 
	echo "apache2 Installed already"
else

	echo "apache2 is not installed installing now"
sudo apt update

sudo apt install apache2 # Command for installing apache

	echo "Apcahe2 Installed successfully" 
fi	

if [ "$apactive"= "active" ] 
then 
	echo "apache2 is already active"
else

	echo "Apache2 is inactive activating now"

	sudo systemctl start apache2.service
	echo "Apache2 is now active"
fi	


if [ "$apenable"= "enabled" ]
then 
	echo "apache2 is already enabled"
else

	echo "apache2 is not enabled enabling now"

 	sudo systemctl enable apache2
	echo "Apcahe2 is now enabled" 
fi	

	echo "moving into log folder"

cd /var/log/apache2/ 

	echo "successfully entered the log folder"

	echo "Now converting log file to tar file"

tar -czvf  /tmp/${name}-httpd-logs-${ts}.tar *.log 

	echo "File converted to tar file"



sudo apt update
sudo apt install awscli

	echo "Moving the file to S3 bucket"

aws s3 \
cp /tmp/${name}-httpd-logs-${ts}.tar \
s3://${s3_bucket}/${name}-httpd-logs-${ts}.tar

	echo "file moved to s3 bucket"





# Performing task 3

size=$(ls -lh /tmp/${name}-httpd-logs-${ts}.tar |awk '{print $5}')

if [ -f "/var/www/html/inventory.html" ]
then
	echo "File inventory.html already exists"

else

	echo "Creating the inventory.html file"
	touch inventory.html
	echo "Log Type         Time Created         Type        Size" >> inventory.html
	echo -e "httpd-logs   		${ts} 				tar          ${size}" >> inventory.html

	echo "Inventory.html created successfully"

fi


if [ -f "/etc/cron.d/automation" ]
then
	echo "Cron Job already exists"

else

	echo "Creating the cron job"
	touch automation


	echo "0 0 * * * root /root/Automation_Project/automation.sh" >> automation

	echo "Cron job Created successfully"


fi
















