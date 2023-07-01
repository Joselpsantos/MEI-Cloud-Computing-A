#!/usr/bin/env python3

import re
import fileinput
import socket
import netifaces as ni

# Obtenha o endereço IP local
ip_address = ni.ifaddresses('enp0s8')[ni.AF_INET][0]['addr']

# Defina a string a ser encontrada e substituída
old_string = r'broker_address\s*=\s*"[^"]+"'
new_string = f'broker_address = "{ip_address}"'

# Use expressão regular para encontrar e substituir a string
for line in fileinput.input('./share/mqtt_sub.py', inplace=True):
    line = re.sub(old_string, new_string, line.rstrip())
    print(line)

