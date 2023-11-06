iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Darme permiso a mi mismo
iptables -A FORWARD -s 192.168.1.2 -j ACCEPT

# Activar HTTP (puerto 80) para la ip 192.168.1.18
iptables -A FORWARD -p tcp -s 192.168.1.18 --dport 80 -j ACCEPT
iptables -A FORWARD -p udp -s 192.168.1.18 --dport 80 -j ACCEPT

# Activar HTTPS (puerto 443) para la ip 192.168.1.18
iptables -A FORWARD -p tcp -s 192.168.1.18 --dport 443 -j ACCEPT
iptables -A FORWARD -p udp -s 192.168.1.18 --dport 443 -j ACCEPT

# Activar DNS (puerto 53)
sudo iptables -A INPUT -p udp --dport 53 -s 192.168.1.18 -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport 53 -d 192.168.1.18 -m state --state ESTABLISHED,RELATED -j ACCEPT

# Otros
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT


# COPILOT

# Activar HTTP (puerto 80) para el interfaz enp0s3(DHCP)
iptables -A INPUT -i enp0s3 -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --sport 80 -j ACCEPT
iptables -A FORWARD -i enp0s3 -o enp0s3 -p tcp --dport 80 -j ACCEPT

# Activar HTTPS (puerto 443) para el interfaz enp0s3(DHCP)
iptables -A INPUT -i enp0s3 -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p tcp --sport 443 -j ACCEPT
iptables -A FORWARD -i enp0s3 -o enp0s3 -p tcp --dport 443 -j ACCEPT

# Activar SSH (puerto 22) para el interfaz enp0s3(DHCP)
iptables -A INPUT -i enp0s3 -p tcp --dport 22 -j ACCEPT

# Activar DNS (puerto 53) para el interfaz enp0s3(DHCP)
iptables -A INPUT -i enp0s3 -p udp --dport 53 -j ACCEPT

# Activar DHCP (puerto 67) para el interfaz enp0s3(DHCP)
iptables -A INPUT -i enp0s3 -p udp --dport 67 -j ACCEPT

