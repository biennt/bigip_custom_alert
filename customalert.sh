#!/bin/sh
## /shared/customalert.sh

alertname=$1

timestamp=`date +"%Y%m%dT%H%M"`
if [[ "$alertname" == "memberdown" ]]; then
   logline=`grep 'monitor status down' /var/log/ltm | tail -n 1`
elif [[ "$alertname" == "pooldown" ]]; then
   logline=`grep 'No members available for pool' /var/log/ltm | tail -n 1`
fi

echo "{" > /tmp/alert-$timestamp.json
echo " \"time\": \"$timestamp\"," >> /tmp/alert-$timestamp.json
echo " \"message\": \"$logline\"" >> /tmp/alert-$timestamp.json
echo "}" >> /tmp/alert-$timestamp.json

#curl -X POST --header "Content-Type: application/json" -d @/tmp/alert-$timestamp.json http://alert_server/
