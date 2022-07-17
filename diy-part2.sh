#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#


# 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile  
# 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile   
# 选择argon为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-ssl-nginx/Makefile  
# 删除自带argon
rm -rf  feeds/luci/themes/luci-theme-argon   
# 替换新版argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon   

# 删除自带adguardhome
rm -rf feeds/packages/net/adguardhome

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 禁止解析 IPv6 DNS 记录
sed -i '/dnsmasq/aoption filter_aaaa 1'  package/network/services/dnsmasq/files/dhcp.conf

#不记录日志
sed -i '/dnsmasq/aoption quietdhcp 1' package/network/services/dnsmasq/files/dhcp.conf

# 禁用内置的 IPv6 管理， /etc/config/network 中 config interface 'wan'、config interface 'lan' 字段下
sed -i "/proto='none'/aset network.\$1.delegate='0'"  package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/suct41/g' package/base-files/files/bin/config_generate 

# Delete default password:password
sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

#修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf
