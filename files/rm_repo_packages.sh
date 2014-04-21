#!/bin/bash

RM_LIST="/root/scripts/configs/rm_list"
REPO="/usr/share/nginx/html/CentOS"

if [[ ! -d $REPO ]]; then
   echo "$REPO doesn't exist! Exiting..."
   echo ""
   exit
fi

while read line; do

  rm -vf `find $REPO 2>/dev/null | grep -i $line | grep -vi 'python\|perl'`

done < $RM_LIST
