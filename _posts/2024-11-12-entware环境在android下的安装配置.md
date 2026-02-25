---
title: "Entware环境在android下的安装配置"
date: 2024-11-12 22:16:00 +0800
excerpt: "android安装Entware环境，挂载目录为opt android环境下"
categories: ["Android"]
tags: ["Android"]
cover: /upload/1112396.jpg
permalink: /archives/1733678873647
---
android安装Entware环境，挂载目录为opt
android环境下
```shell
mount -o rw,remount /

sleep 1

mount -o rw,remount /system

sleep 1

#Entware需要/etc/resolv.conf来解析DNS

busybox echo -e "nameserver 114.114.114.114

nameserver 8.8.8.8

nameserver 8.8.4.4" > /system/etc/resolv.conf

chmod 777 /system/etc/resolv.conf

cp -rf /system/etc/resolv.conf /opt/etc/resolv.conf

sleep 1

mkdir -p /opt

mkdir -p /bin

rm -rf /bin/sh

ln -s /system/bin/sh /bin/sh

mkdir -p /data/entware.arm

mount -o bind /data/entware.arm /opt

cd /opt

#http://bin.entware.net/aarch64-k3.10/installer/alternative.sh

busybox wget -O - http://bin.entware.net/armv7sf-k3.2/installer/alternative.sh | sh

sleep 1

mkdir -p /usr

mkdir -p /opt/usr

mount -o bind /opt/usr /usr

sleep 1

mkdir -p /tmp

mkdir -p /opt/tmp

mount -o bind /opt/tmp /tmp

sleep 1

#OPT环境添加为全局环境变量

if grep -q 'PATH=$PATH:/opt/bin' /system/etc/mkshrc

then

    echo '已添加OPT为全局环境变量'

else

    addpath='[[ $PATH != "*/opt/bin*" ]] && PATH=$PATH:/opt/bin'

    sed -i "/unset p/a $addpath" /system/etc/mkshrc

    addpath='[[ $PATH != "*/opt/sbin*" ]] && PATH=$PATH:/opt/sbin'

    sed -i "/unset p/a $addpath" /system/etc/mkshrc

    echo 'OPT全局环境变量添加成功'

fi
```
