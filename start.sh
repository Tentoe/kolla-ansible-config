#!/bin/bash
openstack server start $(openstack server list --all-projects -f value -c ID)
