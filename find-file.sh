#!/bin/bash


########################################################################
# Name : Jeet Desai
# Date : 16-11-2023
#
# Version: v1
# Description: Search for files
##########################################################################

# set -x # Debug mode

if [ "$#" -ne 2 ]
then
    echo "Please provide the enough parameter"
    exit 1
fi

directory="$1"
file="$2"

if [ ! -d "$directory" ]
then
    echo "Please provide the first param as directory"
    exit 1
fi

echo "Searching for files with name '$file' in '$directory' and its subdirectories..."

find "$directory" -type f -name "$file.*"

echo "Search completed..."







