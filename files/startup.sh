#!/bin/sh

zabbix_server -c /etc/zabbix/zabbix_server.conf
sleep 5

lighttpd -f /etc/lighttpd/lighttpd.conf -D

