# Trabajo Final de Computación en la Nube y Virtualización de Redes y Servicios
*Desarrollo del trabajo final de la asignatura CNVR | Curso 2020/2021*
## Autores: 
- Alejandro Vargas Perez
- Victor Loureiro Sancho
------------

## PASOS
- Clonamos el repositorio:
	 ```sh
	  git clone https://github.com/VictorLoureiro/TrabajoFinalCNVR
	```
- Ejecutamos el script de creación del escenario:
	 ```sh
	  cd TrabajoFinalCNVR
	  chmod 755 createScenario.sh
	  ./createScenario.sh
	```
- Para configurar el escenario, ejecutamos el siguiente script:
	 ```sh
	  openstack stack create -t configure_scenario.yml stack_cnvr
	```
- Para borrar este escenario, ejecutamos el siguiente script:
	 ```sh
	  cd TrabajoFinalCNVR
	  chmod 755 deleteScenario.sh
	  ./deleteScenario.sh
	```

  ------------
