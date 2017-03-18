#!/bin/bash

################################################################################
#
#    filename: webmin_inst.sh
# description: Script to install Puppet 4 Server or Agent
#      author: Andre Mattie
#       email: devel@introsec.ca
#         GPG: 5620 A200 6534 B779 08A8  B22B 0FA6 CD54 93EA 430D
#     bitcoin: 1LHsfZrES8DksJ41JAXULimLJjUZJf7Qns
#        date: 03/18/2017
#
################################################################################

# variables
PORT=$1
DEPENDS="perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python apt-transport-https"
REPO="deb http://download.webmin.com/download/repository sarge contrib"
KEY="jcameron-key.asc"

# ensure script is being run by root
if [ "$(id -u)" -ne "0" ] ; then
    echo "You must be root to run this script"
    exit 1
fi

#TODO add help menu

# update system
apt-get update && apt-get upgrade -y

# mv to tmp directory
cd /tmp

# download Webmin repository key
wget  http://www.webmin.com/$KEY

# add repository key to apt
apt-key add $KEY

# create file for Webmin repository
touch /etc/apt/sources.list.d/webmin.list

# add Webmin repo to /etc/sources.list.d
echo $REPO >> /etc/apt/sources.list.d/webmin.list

# install dependencies
apt-get install -y $DEPENDS

# install webmin
apt-get install -y webmin

#TODO set port number from arguments
