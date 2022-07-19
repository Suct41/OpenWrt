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

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 禁用内置的 IPv6 管理， /etc/config/network 中 config interface 'wan'、config interface 'lan' 字段下
sed -i "/proto='none'/aset network.\$1.delegate='0'"  package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/Suct41/g' package/base-files/files/bin/config_generate 
