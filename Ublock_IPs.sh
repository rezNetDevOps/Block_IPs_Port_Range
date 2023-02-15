#!/bin/bash

list=$(cat IP_list.txt)

# Iterate through the list of numbers
for ip in $list; do 
    # Commands to be executed
    iptables -A INPUT -s $ip -j ACCEPT
done
