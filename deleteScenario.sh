#!/bin/bash

# Obtenemos la ruta absoluta del proyecto
ABS_DIR=`pwd`
VNX_DIR=~/../../mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06

cd $VNX_DIR
sudo vnx -f openstack_lab.xml -x delete-final-scenario
