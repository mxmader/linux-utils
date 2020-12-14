#!/bin/bash
# env used to bypass any existing sessions (e.g. system in graphical.target as default)
env   -u SESSION_MANAGER   -u DBUS_SESSION_BUS_ADDRESS   tightvncserver     -geometry 1600x900
