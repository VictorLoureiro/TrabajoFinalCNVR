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

# Creamos nuevas imagenes con distintas configuraciones en funcion del servidor
# Xenial image with mongo
source admin-openrc.sh
openstack image create --public --disk-format qcow2 --container-format bare --file BBDD-mongo mongo-BBDD

# Arrancamos el escenario
cp $ABS_DIR/openstack_lab.xml $VNX_DIR
cd $VNX_DIR

sudo vnx -f openstack_lab.xml -x create-final-scenario



# Configurar el LBaaS y el FWaas
# Primero hay que entrar automáticamente en network
#slogin network
# Despues se configuran los ficheros neutron.conf y fwaas_driver.ini de neutron del Network
#cd /etc/neutron/
#awk '/service_plugins = / {$3="router,lbaasv2,firewall_v2"}{print}' neutron.conf > tmp.conf && mv tmp.conf neutron.conf
#awk '/service_plugins = / {print $1, $2, $3}' neutron.conf
#awk '/#service_provider / {$1="service_provider"}{print}' neutron_fwaas.conf > tmp.conf && mv tmp.conf neutron_fwaas.conf
#awk '/service_provider / {$2="= FIREWALL:Iptables:neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver:default"}{print}' neutron_fwaas.conf > tmp.conf && mv tmp.conf neutron_fwaas.conf
#awk '/service_provider = / {print $1, $2, $3}' neutron_fwaas.conf
