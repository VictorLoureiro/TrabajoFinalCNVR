#!/bin/bash

# Obtenemos la interfaz externa para configurar a ExtNet
EXT=`ip -4 a | awk '{print $2}' | tr -d ':' | grep en`

# Obtenemos la ruta absoluta del proyecto
ABS_DIR=`pwd`
VNX_DIR=~/../../mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06

/lab/cnvr/bin/get-openstack-tutorial.sh
cd /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06
sudo vnx -f openstack_lab.xml --destroy
sudo vnx -f openstack_lab.xml --create
sudo vnx -f openstack_lab.xml -x start-all,load-img
sudo vnx_config_nat ExtNet $EXT

# Arrancamos Openstack
cp $ABS_DIR/openstack_lab.xml $VNX_DIR
cd $VNX_DIR

sudo vnx -f openstack_lab.xml -x create-final-scenario

# Importamos las imagenes con distintas configuraciones en funcion del servidor
# Xenial image with mongo
cd $ABS_DIR
source admin-openrc.sh
openstack image create --public --disk-format qcow2 --container-format bare --file mongoVM.part mongoVM

# Arrancamos el escenario
#source client-openrc.sh
#openstack stack create -t configure_scenario.yml stack1
