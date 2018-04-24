#!/bin/bash

ip_file_name=link_wan_ip
ip_file_path="/tmp/${ip_file_name}"
shopt -s expand_aliases
alias gdrive='sudo -sH -u joe /home/joe/.local/bin/gdrive'

echo "getting gdrive IDs to delete"
logger "link_ip purging ${ip_file_name} from gdrive root"
for file_id in $(gdrive list --no-header --query "parents in '0AE33lkIYsv-bUk9PVA' and name = '${ip_file_name}'" | awk '{print $1}'); do
    echo "link_ip deleting ${file_id}"
    logger "link_ip deleting ${file_id}"
    gdrive delete "${file_id}"
done

echo "link_ip getting WAN IP"
logger "link_ip getting WAN IP"
curl https://api.ipify.org > "${ip_file_path}"

logger "uploading ${ip_file_path} to gdrive"
gdrive upload "${ip_file_path}"
rm -r "${ip_file_path}"
