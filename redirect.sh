# Activar SNAT con emmascaramiento IP (Masquerade) poniendo el 
# interfaz enp0s3(DHCP) para los paquetes que van hacia fuera.
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE

echo " iptables -L -nv -t nat"