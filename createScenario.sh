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
openstack image create --public --disk-format qcow2 --container-format bare --file mongoVM mongoVM
openstack image create --public --disk-format qcow2 --container-format bare --file web_server web_server

# Arrancamos el escenario
source client-openrc.sh
openstack stack create -t configure_scenario.yml stack1


echo "Waiting for openstack scenario to launch...."
read -p "When done, press INTRO for configure the firewall rules and policies"

# Configuramos el firewall
source client-openrc.sh
IP_ADMIN=`openstack server show admin -c addresses -f value | grep -o 10.1.1.* | awk '{print $1}' | cut -d \, -f 1`
IP_LB=`openstack port list --network net1 | awk '/load/ {print $8}' | grep -o 10.1.1.* | cut -d \' -f 1`
# SSH rule
openstack firewall group rule create --protocol 'tcp' --source-ip-address 10.0.10.0/24 --destination-ip-address $IP_ADMIN --destination-port 22 --action 'allow'
# WWW rule
openstack firewall group rule create --protocol 'tcp' --source-ip-address 10.0.10.0/24 --destination-ip-address $IP_LB --destination-port 80 --action 'allow'
# Other rule
openstack firewall group rule create --protocol 'any' --source-ip-address 10.1.1.0/24 --destination-ip-address 0.0.0.0 --action 'allow'

#Clone our repo
#git clone https://AlexVaPe:31f025a736d90997ac9beb5f51efa2903f702bd4@github.com/VictorLoureiro/TrabajoFinalCNVR

echo "Firewall configured"
read -p "Press INTRO for configure the web app on the servers"

# Configuration of the app
#source client-openrc.sh
#IP_S1=`neutron lbaas-member-list http_pool`
#POOL_NAME=`neutron lbaas-pool-list -c 'name' -f 'value'`
#POOL_NAME=`neutron lbaas-pool-list -c 'name' -f 'value'`


