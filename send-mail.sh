#!/bin/bash


###########################################################################
# Name: Jeet Desai
# Date: 18-11-2023
#
# Version: v1
# Description: Send mail to person
###########################################################################

# set -x # Debug mode
# set -e 

# sender=""
# receiver=""

# read -p "Please enter subject: " subject
# read -p "Please enter body: " body

email_file="/home/jeet/Documents/shell-scripts/email.txt"
cat $email_file

read -p "Please attach file name (or leave balck if none): " file

if [ -f "$file" -a -s "$file" ]
then
	echo "File Exist"
	#Mime=$(file --mime-type "$file" | sed 's/.*: //')
	#echo "$Mime"
	#echo "$body" | mail -s "$subject" -a "Content-Type:$Mime" -A "$file" "$receiver"
	sendmail -A "$file" -i -t < "$email_file" 2> ./error.log
else
	echo "File not exist"
	sendmail -i -t < "$email_file" 2> ./error.log
	#echo "$body" | mail -s "$subject" "$receiver"
fi

if [ $? -eq 0 ]
then 
	rm ./error.log
	echo "Email sent successfully"
else
	echo "Something went wrong while sending email, Please check error.log file"
fi






