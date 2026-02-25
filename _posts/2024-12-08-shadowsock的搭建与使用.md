---
title: "Shadowsocks的搭建与使用"
date: 2024-12-08 08:42:00 +0800
excerpt: "服务端：搭建环境Centos7 方法一:使用yum源安装方式ss-server 方法二:基于python2.6以上pip安装 shadowsocks客户端/outline客户端 客户端任选其一"
categories: []
tags: []
cover: https://images3.alphacoders.com/931/931158.jpg
permalink: /archives/1750302846810
---
#### 服务端：搭建环境Centos7

##### 方法一:使用yum源安装方式ss-server
```
[root@akkun ~]# yum install epel-release -y
[root@akkun ~]# wget -O /etc/yum.repos.d/librehat-shadowsocks-epel-7.repo https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo
[root@akkun ~]# yum makecache
[root@akkun ~]# yum install shadowsocks-libev -y
[root@akkun ~]# vi /etc/shadowsocks-libev/config.json
{

    "server":"0.0.0.0",

    "server_port":8388,

     "local_port":1080,

    "password":"suiyi",

     "timeout":60,

     "method":"chacha20-ietf-poly1305"

}

#使用systemd
[root@akkun ~]# systemctl enable shadowsocks-libev.service
[root@akkun ~]# service shadowsocks-libev restart
```
##### 方法二:基于python2.6以上pip安装
```
[root@akkun ~]# yum install python-setuptools && easy_install pip

[root@akkun ~]# yum install shadowsocks -y

[root@akkun ~]# vi /etc/shadowsocks/config.json

{

    "server":"0.0.0.0",

    "server_port":8388,

     "local_port":1080,

    "password":"suiyi",

     "timeout":60,

     "method":"chacha20-ietf-poly1305"

}

#使用systemd

[root@akkun ~]# systemctl enable shadowsocks-server.service

[root@akkun ~]# service shadowsocks-server restart
```
#### shadowsocks客户端/outline客户端

客户端任选其一

[六大平台客户端下载](https://shadowsocks.org/en/download/clients.html)
