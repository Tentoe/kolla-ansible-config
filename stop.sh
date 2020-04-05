#!/bin/bash

for server in $(openstack server list --all-projects -f value -c ID)
do
echo $server
openstack server stop $server
done
