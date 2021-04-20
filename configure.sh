#!/usr/bin/env bash

if [ $# -lt 2 ]
then
	echo "usage: ./configure mydomain.com ldap_pass"
        exit
fi

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ ! -f $SCRIPT_DIR/mailserver.env.bak ]
then
 cp $SCRIPT_DIR/mailserver.env $SCRIPT_DIR/mailserver.env.bak
 cp $SCRIPT_DIR/.env $SCRIPT_DIR/.env.bak
fi


DOMAIN=$(echo $1 | cut -d. -f1)
DOMAIN_TLD=$(echo $1 | cut -d. -f2)
LDAP_PASS=$2
HOSTNAME=$(hostname | cut -d. -f1)

sed -i -e "s/MYDOMAIN/$DOMAIN/g" -e "s/MYDOMTLD/$DOMAIN_TLD/g" -e "s/MYPASSWORD/$LDAP_PASS/g" $SCRIPT_DIR/mailserver.env
sed -i -e "s/MYHOSTNAME/$HOSTNAME/g" -e "s/MYDOMAIN/$DOMAIN.$DOMAIN_TLD/g" $SCRIPT_DIR/.env
