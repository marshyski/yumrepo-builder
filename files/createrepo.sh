#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## LAZY CREATEREPO SCRIPT                 ##
## 19MAY2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

umask 0022

CENTOS_64_OS="/usr/share/nginx/html/CentOS/6.4/os/x86_64/Packages/"
CENTOS_64_UP="/usr/share/nginx/html/CentOS/6.4/updates/x86_64/Packages/"
CENTOS_64_DATA=`dirname "$CENTOS_64_OS"`/repodata
CENTOS_64_DATA2=`dirname "$CENTOS_64_UP"`/repodata

#CENTOS_59_OS="/usr/share/nginx/html/CentOS/CentOS/5.9/os/x86_64/Packages/"
#CENTOS_59_UP="/usr/share/nginx/html/CentOS/5.9/updates/x86_64/Packages/"
#CENTOS_59_DATA=`dirname "$CENTOS_59_OS"`/repodata
#CENTOS_59_DATA2=`dirname "$CENTOS_59_UP"`/repodata

createrepo `dirname "$CENTOS_64_OS"`
createrepo `dirname "$CENTOS_64_UP"`
#createrepo `dirname "$CENTOS_59_OS"`
#createrepo `dirname "$CENTOS_59_UP"`

chmod -f 0755 $CENTOS_64_OS
chmod -f 0755 $CENTOS_64_OS/*
chmod -f 0755 $CENTOS_64_UP
chmod -f 0755 $CENTOS_64_UP/*

chmod -f 0755 $CENTOS_64_DATA
chmod -f 0755 $CENTOS_64_DATA2
chmod -f 0644 $CENTOS_64_DATA/*
chmod -f 0644 $CENTOS_64_DATA2/*

#chmod -f 0755 $CENTOS_59_OS
#chmod -f 0755 $CENTOS_59_OS/*
#chmod -f 0755 $CENTOS_59_UP
#chmod -f 0755 $CENTOS_59_UP/*

#chmod -f 0755 $CENTOS_59_DATA
#chmod -f 0755 $CENTOS_59_DATA2
#chmod -f 0644 $CENTOS_59_DATA/*
#chmod -f 0644 $CENTOS_59_DATA2/*
