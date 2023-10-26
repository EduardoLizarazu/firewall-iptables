## Eliminar Reglas Actuales
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

## Politicas por Defecto
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

### Comenzamos a filtrar la seguridad
## Nota: enp0s3 es el interface con acceso a internet y enp0s8 a la LAN

/sbin/iptables -A INPUT -i lo -j ACCEPT

# Al fw tenemos acceso desde la red local
# enp8 [192.168.222.1/24]
iptables -A INPUT -s 192.168.1.0/24 -i enp0s8 -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 -i enp0s3 -j ACCEPT

# Enmascaaramiento de la red local
# y activamos el BIT de FORWARDING, ojo: importante!
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o enp0s3 -j MASQUERADE

# Con esto permitimos hacer forward de paquetes en el fw, o sea
# que otras maquinas pueden salir a travez del fw.
echo 1 > /proc/sys/net/ipv4/ip_forward

## Impedimos el acceso a puetos bien conocidos (well known ports)
iptables -A INPUT -s 0.0.0.0/0 -p tcp --dport 1:1024 -j DROP
iptables -A INPUT -s 0.0.0.0/0 -p udp --dport 1:1024 -j DROP

# Cerramos un puesto  de gestion: webmin
iptables -A INPUT -s 0.0.0.0/0 -p tcp --dport 10000 -j DROP
echo "Listo. Verifique las  reglas aplicadas con: iptables -L -n"

# Fin del script.