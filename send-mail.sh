#!/bin/bash


###########################################################################
# Name: Jeet Desai
# Date: 18-11-2023
#
# Version: v1
# Description: Send mail shell script
#
# sudo apt install sendmail
#
# Open your sendmail.mc file for editing. This file is often located at /etc/mail/sendmail.mc. Add the following lines to the file: 
# FEATURE(`authinfo', `hash -o /etc/mail/authinfo.db')dnl
# define(`SMART_HOST', `smtp.gmail.com')dnl
# define(`RELAY_MAILER_ARGS', `TCP $h 587')dnl
#
# Create a file called /etc/mail/authinfo and add the following line: sudo vim /etc/mail/authinfo
# AuthInfo:smtp.gmail.com "U:your_username@gmail.com" "I:your_username@gmail.com" "P:your_app_password" "M:PLAIN"
# 
# Run the following commands to generate the authinfo.db file:
# sudo makemap hash /etc/mail/authinfo < /etc/mail/authinfo
# sudo sh -c 'm4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf'
# sudo mkdir -p /etc/mail/auth
# sudo chmod 700 /etc/mail/auth
#
# Restart the sendmail service with sudo to apply the changes:
# sudo service sendmail restart   # On SysV systems
# sudo systemctl restart sendmail # On systemd systems
#
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
	sudo sendmail -A "$file" -i -t < "$email_file" 2> ./error.log
else
	echo "File not exist"
	sudo sendmail -i -t < "$email_file" 2> ./error.log
	#echo "$body" | mail -s "$subject" "$receiver"
fi

if [ $? -eq 0 ]
then 
	rm ./error.log
	echo "Email sent successfully"
else
	echo "Something went wrong while sending email, Please check error.log file"
fi

