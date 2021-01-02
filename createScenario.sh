#!/bin/bash

# Obtenemos la interfaz externa para configurar a ExtNet
EXT=ifconfig | grep enp | awk '{print $1}' | tr -d ':'

# Obtenemos la ruta absoluta del proyecto
ABS_DIR=`pwd`
VNX_DIR=~/../../mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06

/lab/cnvr/bin/get-openstack-tutorial.sh
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06
sudo vnx -f openstack_lab.xml --create
sudo vnx -f openstack_lab.xml -x start-all,load-img
vnx_config_nat ExtNet $EXT

# Arrancamos el escenario
cp $ABS_DIR/openstack_lab.xml $VNX_DIR
cd $VNX_DIR
sudo vnx -f openstack_lab.xml -x create-final-scenario
