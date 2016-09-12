#!/bin/bash
# -------------------------------------------------------------
# @file     certbot_update.sh
# @brief    Script to renew LetsEncrypt certificates.  This is
#           designed to be run from cron periodically.  A log
#           message is posted to the KST log server with the
#           result.  Local log file renewal.log is also 
#           updated.
#
# @author   Harlan Shoop
# @version  1.0
# @date     2016-07-19
# -------------------------------------------------------------

# setup log variables
MYNAME="CertServer"
DOMAIN="mesh.kstechnologies.com"
MESSAGE="Certificate renewal for $DOMAIN successful!"
TYPE="log"

# Run the renewal script
sudo /home/ec2-user/certbot/certbot-auto certonly --standalone --keep -n -d $DOMAIN

# Parse the result
LE_STATUS=$?
if [ "$LE_STATUS" != 0 ]; then
    TYPE="error"
    MESSAGE="Certificate Renewal Failed for $DOMAIN."
fi

# give local output
echo $MESSAGE

# log the result; NOTE: log server sec group must accept connections from this host
curl -H "Content-Type: application/json" -X POST -d '{"type":"'"$TYPE"'","module":"letsencrypt","application":"'"$MYNAME"'","message":"'"$MESSAGE"'"}' "http://logs.kstechnologies.com:8106/log"
