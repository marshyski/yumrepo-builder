#!/bin/bash

umask 0022

CENTOS_65_OS='/usr/share/nginx/html/CentOS/6.5/os/x86_64/Packages/'
CENTOS_65_UP='/usr/share/nginx/html/CentOS/6.5/updates/x86_64/Packages/'
CENTOS_65_DATA=`dirname "$CENTOS_65_OS"`/repodata
CENTOS_65_DATA2=`dirname "$CENTOS_65_UP"`/repodata

# Remove any HTML or image files from directories
rm -f `find $CENTOS_65_OS $CENTOS_65_UP | grep -i '\.html\|\.gif'`

createrepo -v `dirname "$CENTOS_65_OS"`
createrepo -v `dirname "$CENTOS_65_UP"`

chmod -f 0755 $CENTOS_65_OS
chmod -f 0755 $CENTOS_65_OS/*
chmod -f 0755 $CENTOS_65_UP
chmod -f 0755 $CENTOS_65_UP/*

chmod -f 0755 $CENTOS_65_DATA
chmod -f 0755 $CENTOS_65_DATA2
chmod -f 0644 $CENTOS_65_DATA/*
chmod -f 0644 $CENTOS_65_DATA2/*
