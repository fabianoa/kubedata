#!/bin/bash
set -xe

#cp templates/* /opt/ranger_usersync/templates

cp -rf /install.properties /opt/ranger_usersync/install.properties

./setup.sh

sleep 300

./ranger-usersync-services.sh start
tail -f /var/log/ranger/usersync/usersync-ranger-usersync-*-*-.log