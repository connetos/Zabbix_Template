#!/bin/bash

if [ $3 = "memory-total" ]; then
    snmpget -v 2c -c $1 $2 1.3.6.1.4.1.44781.1.2.0 | awk -F'"' '{print $2}' | sed 's/KB//g'
elif [ $3 = "memory-usage" ]; then
    snmpget -v 2c -c $1 $2 1.3.6.1.4.1.44781.1.3.0 | awk -F'"' '{print $2}' | sed 's/KB//g'
elif [ $3 = "memory-free" ]; then
    snmpget -v 2c -c $1 $2 1.3.6.1.4.1.44781.1.4.0 | awk -F'"' '{print $2}' | sed 's/KB//g'
fi
