#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## CLEAN UNWANTED YUM REPO PACKAGES       ##
## 18MAY2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

RM_LIST="/root/randomz/configs/rm_list"
REPO="/usr/share/nginx/html/CentOS"

if [[ ! -d $REPO ]]; then
   echo "$REPO doesn't exist! Exiting..."
   echo ""
   exit
fi

while read line; do

  rm -vf `find $REPO 2>/dev/null | grep -i $line | grep -vi 'python\|perl'`

done < $RM_LIST
