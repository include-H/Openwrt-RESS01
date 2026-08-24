#!/bin/sh

#LAN 静态IP + 网关 + DNS
uci set network.lan.ipaddr='192.168.1.253/24'
uci set network.lan.gateway='192.168.1.1'
uci delete network.lan.dns
uci add_list network.lan.dns='223.5.5.5'
uci add_list network.lan.dns='114.114.114.114'
uci commit network

#LAN 不启动 DHCPv4/DHCPv6/RA/NDP 服务器
uci set dhcp.lan.ignore='1'
uci set dhcp.lan.dhcpv6='disabled'
uci set dhcp.lan.ra='disabled'
uci set dhcp.lan.ndp='disabled'

#dnsmasq 全局参数
uci set dhcp.dnsmasq.domainneeded='1'
uci set dhcp.dnsmasq.boguspriv='1'
uci set dhcp.dnsmasq.filterwin2k='0'
uci set dhcp.dnsmasq.localise_queries='1'
uci set dhcp.dnsmasq.rebind_protection='1'
uci set dhcp.dnsmasq.rebind_localhost='1'
uci set dhcp.dnsmasq.local='/lan/'
uci set dhcp.dnsmasq.domain='lan'
uci set dhcp.dnsmasq.expandhosts='1'
uci set dhcp.dnsmasq.min_cache_ttl='3600'
uci set dhcp.dnsmasq.use_stale_cache='3600'
uci set dhcp.dnsmasq.cachesize='8000'
uci set dhcp.dnsmasq.nonegcache='1'
uci set dhcp.dnsmasq.authoritative='1'
uci set dhcp.dnsmasq.readethers='1'
uci set dhcp.dnsmasq.leasefile='/tmp/dhcp.leases'
uci set dhcp.dnsmasq.resolvfile='/tmp/resolv.conf.d/resolv.conf.auto'
uci set dhcp.dnsmasq.nonwildcard='1'
uci set dhcp.dnsmasq.localservice='1'
uci set dhcp.dnsmasq.ednspacket_max='1232'
uci set dhcp.dnsmasq.filter_aaaa='0'
uci set dhcp.dnsmasq.filter_a='0'
uci commit dhcp

exit 0
