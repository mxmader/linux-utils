#!/bin/bash

set -e

dns_name="$1"
value="$2"

if [[ ! "$1" || ! "$2" ]]; then

	echo "Usage: $0 <dns name> <value>"
	exit 1
fi

interval=30

while true; do

	echo "`date` Checking value in DNS for $dns_name - waiting for $value"
	ip=`dig $dns_name +short`

	if [ ! "$ip" ]; then

		zenity --info --text="$dns_name appears to be undefined"
		exit 1
	fi

	if [[ "$ip" == "$value" ]]; then

		zenity --info --text="$dns_name = $value"
		exit 0
	fi

	echo "`date` got $ip for $dns_name (not $value)"
	echo "`date` waiting $interval sec to check again..."
	sleep $interval
done
