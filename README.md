# Script VPN ULL
Hecho por Anabel Díaz Labrador.

alu0101206011

## Sistema operativo
Linux

Probado en Ubuntu 22.04 LTS y Ubuntu 20.04 LTS y Ubuntu 18.04 LTS.

## Versión
Actualmente en se encuentra en 1.5v

Última actualización: 1 nov 2022

## Funcionamiento
Script que automatiza el proceso de configuración, conexión
y desconexión del VPN de la Universidad de La Laguna.

Para registrar los datos de usuario de la VPN usar:
```
sudo ./vpnull.sh -R
```

Para conectarse a la VPN usar:
```
sudo ./vpnull.sh -ON
```

La primera vez que se ejecute este script, si no se ha registrado antes, se le preguntará su nombre de usuario de la Universidad de La Laguna (aluxxxxxxxxxx)
y su contraseña.

Para desconectarse de la VPN usar:
```
sudo ./vpnull.sh -OFF
```

Para borrar el registro/usuario de la VPN actual usar:
```
sudo ./vpnull.sh -D
```

Para ver si la VPN está activada o desactivada usar:
```
sudo ./vpnull.sh -S
```

Para ver la ayuda del script usar:
```
sudo ./vpnull.sh -h
```

## Requisitos
Es necesario ejecutar el script con permisos de administrador (sudo).

Para poder usar este script es necesario haber realizado lo siguiente:
```terminal
sudo apt-get -y update
sudo apt install -y network-manager-vpnc-gnome
sudo apt install net-tools
chmod u+x vpnull.sh
``` 



## Referencias
[Servicio de VPN de la ULL](https://www.ull.es/servicios/stic/2020/12/01/servicio-de-vpn-de-la-ull/)

[VPN GUIA ULL](https://docs.google.com/document/d/1xhSRVqo6y5HYtQQtBemLEwDG6a_yjGlzrxjwuYxIQAk/edit)


