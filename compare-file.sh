#!/bin/bash


###########################################################################
# Name: Jeet Desai
# Date: 17-11-2023
#
# Version: v1
# Description: Compare 2 files
###########################################################################

# set -x # Debug mode

if [ "$#" -ne 2 ]
then
    echo "Please provide the enough parameter"
    exit 1
fi

first="$1"
second="$2"

if [ ! -e "$first" -o ! -e "$second" ]
then
    echo "Please provide the valid path with file"
    exit 1
fi

echo "Comparing for files with name '$first' and '$second'..."

sdiff "$first" "$second"

echo "Compare completed..."


