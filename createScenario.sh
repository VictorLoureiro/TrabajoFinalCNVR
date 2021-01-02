#!/bin/bash

/lab/cnvr/bin/get-openstack-tutorial.sh
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06
sudo vnx -f openstack_lab.xml --create
sudo vnx -f openstack_lab.xml -x start-all,load-img
