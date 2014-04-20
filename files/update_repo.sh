#!/bin/bash
############################################
## CREATED BY TIM SKI | MARSHYSKI(DOT)COM ##
## MARSHYSKI[AT]GMAIL[DOT]COM             ##
## UPDATE YUM REPOS                       ##
## 19MAY2013                              ##
## TESTED ON RHEL 5-6                     ##
############################################

#CENTOS_59_OS="/usr/share/nginx/html/CentOS/5.9/os/x86_64/Packages/"
#CENTOS_59_UP="/usr/share/nginx/html/CentOS/5.9/updates/x86_64/Packages/"

CENTOS_64_OS="/usr/share/nginx/html/CentOS/6.4/os/x86_64/Packages/"
CENTOS_64_UP="/usr/share/nginx/html/CentOS/6.4/updates/x86_64/Packages/"

DATE=`date +%d%b`
#CURRENT59="/root/currentrepo59.$DATE.log"
#UPDATE59="/root/updatedrepo59.$DATE.log"
CURRENT64="/root/currentrepo64.$DATE.log"
UPDATE64="/root/currentrepo64.$DATE.log"
MIRROR="mirror.umd.edu"
FREEZE="/usr/share/nginx/html/CentOS"

## FREEZE REPO TO AVOID ALTERATIONS
if [[ $1 = "-p" ]]; then

   tar -zcvf $FREEZE/$DATE.tar.gz --exclude=*.log
   exit

fi


## UPDATE REPO FROM UMD
if [[ `ping -c3 $MIRROR | grep '0% packet'` != "" ]]; then

    ls -1R $CENTOS_64_OS > $CURRENT64
#    ls -1R $CENTOS_59_OS > $CURRENT59

    cd $CENTOS_64_OS
    wget -r -nd -nc --reject "i386" $MIRROR/centos/6.4/os/x86_64/Packages/
    cd $CENTOS_64_UP
    wget -r -nd -nc --reject "i386" $MIRROR/centos/6.4/updates/x86_64/Packages/
 #   cd $CENTOS_59_OS
 #   wget -r -nd -nc --reject "i386" $MIRROR/centos/5.9/os/x86_64/CentOS/
 #   cd $CENTOS_59_UP
 #   wget -r -nd -nc --reject "i386" $MIRROR/centos/5.9/updates/x86_64/RPMS


    createrepo `dirname "$CENTOS_64_OS"`
    createrepo `dirname "$CENTOS_64_UP"`
#    createrepo `dirname "$CENTOS_59_OS"`
#    createrepo `dirname "$CENTOS_59_UP"`
    

    ls -1R $CENTOS_64_OS > $UPDATE64
#    ls -1R $CENTOS_59_OS > $UPDATE59

    echo ""
    echo "`diff $CURRENT64 $UPDATE64 | grep '>' | wc -l` files have been added in our local 6.4 repo."
#    echo ""
#    echo "`diff $CURRENT59 $UPDATE59 | grep '>' | wc -l` files have been added in our local 5.9 repo."	

else
   
    echo ""
    echo "Could not connect to UMD mirror"

fi
