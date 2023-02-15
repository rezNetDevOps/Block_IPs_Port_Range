#!/bin/bash

logfiles=/var/log/IPBlocker.log
errorlogs=/var/log/IPBlocker_error.log

list=$(cat IP_list.txt)

# Iterate through the list of numbers
for ip in $list; do 
    # Commands to be executed
    date >>$logfiles
    iptables -A INPUT -s $ip -j ACCEPT 1>>$logfiles 2>>$errorlogs
done
