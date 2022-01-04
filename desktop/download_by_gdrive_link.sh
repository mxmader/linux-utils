#!/bin/bash

id=`echo "$1" | cut -d'?' -f2 | sed -e "s/id=//"`

gdrive download $id
