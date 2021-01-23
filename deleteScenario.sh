#!/bin/bash

source client-openrc.sh
# Borramos el stack
openstack stack delete stack_cnvr
# Destruimos el escenario
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06/
sudo vnx -f openstack_lab.xml --destroy
