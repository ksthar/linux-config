#!/bin/bash
# -------------------------------------------------------------
# @file     letsencrypt_update.sh
# @brief    Script to renew LetsEncrypt certificates.  This is
#           designed to be run from cron periodically.  A log
#           message is posted to the KST log server with the
#           result.  Local log file renewal.log is also 
#           updated.
#
# @author   Harlan Shoop
# @version  1.0
# @date     2016-04-28
# -------------------------------------------------------------

# setup log variables
MYNAME="PSAP LE"
MESSAGE="Certificate renewal script ran with no errors"
TYPE="log"

# Run the renewal script
sudo /home/ec2-user/letsencrypt/letsencrypt-auto renew -nvv > /var/log/letsencrypt/renewal.log 2>&1

# Parse the result
LE_STATUS=$?
if [ "$LE_STATUS" != 0 ]; then
    TYPE="error"
    MESSAGE="Certificate Renewal Failed. See renewal.log for details"
fi

# log the result; NOTE: log server sec group must accept connections from this host
curl -H "Content-Type: application/json" -X POST -d '{"type":"'"$TYPE"'","module":"letsencrypt","application":"'"$MYNAME"'","message":"'"$MESSAGE"'"}' "http://logs.kstechnologies.com:8106/log"
