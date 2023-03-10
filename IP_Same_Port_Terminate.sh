#!/bin/bash 

# Create IP_list.txt to save terminated IPs
touch IP_list.txt
> IP_list.txt
logfiles=/var/log/IPBlocker.log
errorlogs=/var/log/IPBlocker_error.log

for port_num in {64001..65000}; do
    netstat -anp | grep $port_num
    date >>$logfiles
    IPs=$(netstat -anp | grep $port_num | awk '{print $5}' | cut -d: -f1) 2>>$errorlogs
    if [ $(echo "$IPs" | wc -w) -gt 1 ]; then
        echo "More than one IP found on port $port_num!"
        echo "IPs found: $IPs"
        echo "Terminating one of them..."
        IP_to_terminate=$(echo $IPs | cut -d' ' -f1)
        date >>$logfiles
        sudo iptables -A INPUT -s $IP_to_terminate -j DROP 1>>$logfiles 2>>$errorlogs

        # Append terminated IP to IP_list.txt
        echo $IP_to_terminate >> IP_list.txt
    fi
done
