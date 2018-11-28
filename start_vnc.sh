#!/bin/bash

if [[ "$*" == *"macbook-air" ]]; then
    env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS tightvncserver -geometry 1440x900
else
    env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS tightvncserver -geometry 1900x1080
fi
