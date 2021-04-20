#!/usr/bin/env bash

if [ $# -lt 2 ]
then
	echo "usage: ./configure mydomain.com ldap_pass"
        exit
fi
if [ ! -f mailserver.env.bak ]
then
 cp mailserver.env mailserver.env.bak
 cp .env .env.bak
fi


DOMAIN=$(echo $1 | cut -d. -f1)
DOMAIN_TLD=$(echo $1 | cut -d. -f2)
LDAP_PASS=$2
HOSTNAME=$(hostname | cut -d. -f1)

sed -i -e "s/MYDOMAIN/$DOMAIN/g" -e "s/MYDOMTLD/$DOMAIN_TLD/g" -e "s/MYPASSWORD/$LDAP_PASS/g" mailserver.env
sed -i -e "s/MYHOSTNAME/$HOSTNAME/g" -e "s/MYDOMAIN/$DOMAIN.$DOMAIN_TLD/g" .env
