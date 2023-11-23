#!/bin/bash

###########################################################################
# Name: Jeet Desai
# Date: 18-11-2023
#
# Version: v1
# Description: Send mail shell script using curl
###########################################################################

# set -x # Debug mode
# set -e 

sender="email@example.com"
gapp="google app password"

read -p "Please enter recipient email: " receiver

read -p "Please enter subject: " sub

echo "Please enter body: " 
cat > bodyfile.txt 
body=$(cat bodyfile.txt)

read -p "Please attach file name (or leave balck if none): " file

if [ -z "$file" ] 
then 
    curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
    	    --mail-from "$sender" \
            --mail-rcpt "$receiver" \
            --user "$sender:$gapp" \
            -T - << EOF
From: $sender
To: $receiver
Subject: $sub
$body 
EOF

else
    MIMEType=`file --mime-type "$file" | sed 's/.*: //'`
    curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
    --mail-from "$sender" \
    --mail-rcpt "$receiver" \
    --user "$sender:$gapp" \
    -H "Subject: $sub" -H "From: $sender" -H "To: $receiver" -F \
    '=(;type=multipart/mixed' -F "=$body;type=text/plain" -F \
    "file=@$file;type=$MIMEType;encoder=base64" -F '=)'
     
fi

if [ $? -eq 0 ]
then
	rm bodyfile.txt
	echo "Email sent successfully"
else
	echo "Something went wrong while sending email."
fi

