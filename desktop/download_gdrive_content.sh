#!/bin/bash

folder_id='0B033lkIYsv-bNE5Dd1NuMVFDREE'

object_ids=$(gdrive list --query "'${folder_id}' in parents" | grep -v '^Id' | awk '{print $1}')

for id in $object_ids; do

    mime_type=$(gdrive info "$id" | grep '^Mime:' | awk '{print $2}')

    case "${mime_type}" in 

        "application/vnd.google-apps.drawing"|"application/vnd.google-apps.document")
            echo "[$id]"
            echo " mime type: ${mime_type}"
            echo " downloading as pdf"
            gdrive export --mime application/pdf "${id}"
        ;;
        
        *)
            true
        ;;
        
    esac

done
