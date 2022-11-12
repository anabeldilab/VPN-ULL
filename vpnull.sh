#! /bin/bash

# Hecho por Anabel Díaz Labrador
# alu0101206011
# 
# Versión 1.5v
# Última actualización: 1 nov 2022
#
# Script que automatiza el proceso de configuración, conexión
# y desconexión del VPN de la Universidad de La Laguna
#
# Necesario ejecutar con permisos de administrador (sudo)



CONNECT="-ON"
DISCONNECT="-OFF"
CONNECTED=0
FILE=/etc/vpnc/vpnull.conf

exit_error()
{
  echo "$1" 1>&2
  exit 1
}

vpn_running_check()
{
  if ifconfig tun0 > /dev/null 2>&1; then
    CONNECTED=1
    
  else
    CONNECTED=0
  fi  
}


process()
{
  vpn_running_check
  if [ $1 = $CONNECT ]; then
    if [ $CONNECTED = 1  ]; then
      exit_error "Ya se encuentra conectado a la VPN."
    fi
    echo "Conectando..."
    sudo vpnc-connect vpnull.conf --local-port 0 1>&2
  elif [ $1 = $DISCONNECT ]; then
    if [ $CONNECTED = 0 ]; then
      exit_error "No se puede desconectar de la VPN porque ya se encuentra desconectado."
    fi
    echo "Desconectando..."
    sudo vpnc-disconnect 
  fi
}

usage()
{
  echo "usage: vpnull [-OFF]or[-ON] to disconnect or connect."
  echo "       vpnull [-R ó --reset] to reset data."
  echo "       vpnull [-S ó --status] to see the current status."
  echo
  echo "Must be run with administrator privileges (sudo)."
} 

initial()
{
  if [ -f "$FILE" ]; then
    echo "Fichero $FILE correcto"
  else 
    echo "Creando fichero $FILE..."
    echo "IPSec gateway vpn.ull.es" >> $FILE
    echo "IPSec ID ULL" >> $FILE
    echo "IPSec secret usu4r10s" >> $FILE
  
    while true; do
      read -p 'VPN Username: ' user
      read -s -p 'Password: ' password
      echo
      echo "¿Están correctos sus datos? Luego no se podrán cambiar. Y/n"
      read answer
      if [[ $answer == "Y" || $answer == "y" ]]; then
        break
      fi
    done
  
    echo "Xauth username $user" >> $FILE
    echo "Xauth password $password" >> $FILE
  
    echo "Datos introducidos con éxito."
  fi
}

if [ $(whoami) != "root" ]; then
  echo "Debe ejecutar con permisos de administrador (sudo)."
fi

while [ "$1" != "" ]; do
  case $1 in
    -h | --help )
      usage
      exit 0
      ;;
    -ON | --online )
      initial
      process -ON
      exit 0
      ;;

    -OFF | --offline )
      process -OFF
      exit 0
      ;;
     -R | --reset )
      rm $FILE
      echo "Reseteado con éxito"
      exit 0
      ;;
     -S | --status )
      vpn_running_check
      if [ $CONNECTED = 1  ]; then
        echo "Usted tiene la VPN activada"
      else
        echo "Usted tiene la VPN desactivada"
      fi
      exit 0
      ;;
    * )
    echo "La opción $1 no existe, por favor indique una opción válida."
    usage 
    exit_error "----------------------------------------------------------------"
  esac
  shift
done    

echo "Introduzca algún argumento. "
usage 
exit_error "----------------------------------------------------------------"
