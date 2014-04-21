#!/bin/bash

CENTOS_65_OS='/usr/share/nginx/html/CentOS/6.5/os/x86_64/Packages/'
CENTOS_65_UP='/usr/share/nginx/html/CentOS/6.5/updates/x86_64/Packages/'

DATE=`date +%d%b`
CURRENT65="/root/currentrepo65.$DATE.log"
UPDATE65="/root/currentrepo65.$DATE.log"
MIRROR='mirror.umd.edu'
FREEZE='/usr/share/nginx/html/CentOS'

# Freeze repo to avoid alterations or backup changes
if [[ $1 = '-p' ]]; then
  tar -zcvf $FREEZE/$DATE.tar.gz --exclude=*.log
  exit
fi

# Update repo from mirror
if [[ `ping -c3 $MIRROR | grep '0% packet'` != "" ]]; then
  ls -1R $CENTOS_65_OS > $CURRENT65

  cd $CENTOS_65_OS
  wget -r -nd -nc --reject 'i386' $MIRROR/centos/6.5/os/x86_64/Packages/
  cd $CENTOS_65_UP
  wget -r -nd -nc --reject 'i386' $MIRROR/centos/6.5/updates/x86_64/Packages/

  createrepo `dirname "$CENTOS_65_OS"`
  createrepo `dirname "$CENTOS_65_UP"`
    
  ls -1R $CENTOS_65_OS > $UPDATE65

  echo ""
  echo "`diff $CURRENT65 $UPDATE65 | grep '>' | wc -l` files have been added in our local 6.5 repo."
else
  echo ""
  echo "Could not connect to UMD mirror"
fi
