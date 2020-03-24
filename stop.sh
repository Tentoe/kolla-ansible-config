#!/bin/bash
openstack server stop $(openstack server list --all-projects -f value -c ID)
