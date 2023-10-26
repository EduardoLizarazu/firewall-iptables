#!/bin/bash

# Este script realiza las siguientes acciones:
    #1. Borra todas las reglas de iptables de las tablas filter, nat
    #2. Establece la política por defecto de las cadenas de las tablas filter, nat a Denegar

# Eliminar reglas en las tablas filter y nat:
iptables -t filter -F
iptables -t nat -F

# Reiniciar los contadores en las tablas filter y nat:
iptables -t filter -Z
iptables -t nat -Z

# Politicas por Defecto
# Aceptar todo el tráfico en las tres chain (INPUT, OUTPUT, FORWARD)
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP