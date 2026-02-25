---
title: "ECMP环境中mysql启动失败探究"
date: 2024-12-04 20:05:00 +0800
excerpt: "MySQL无法重启问题解决Warning: World-writable config file ‘/etc/my.cnf’ is ignored 在关闭数据库的命令发现mysql关不了，提示Warning: Wo..."
categories: []
tags: []
cover: /upload/677361.jpg
permalink: /archives/ecmphuan-jing-zhong-mysqlqi-dong-shi-bai-tan-jiu
---
MySQL无法重启问题解决Warning: World-writable config file ‘/etc/my.cnf’ is ignored

在关闭数据库的命令发现mysql关不了，提示Warning: World-writable config file ‘/etc/my.cnf’ is ignored ，大概意思是权限全局可写，任何一个用户都可以写。mysql担心这种文件被其他用户恶意修改，所以忽略掉这个配置文件。这样mysql无法关闭。

查看文件：
```
[root@ttlsa ~]# ll /opt/etc/my.cnf

-rwxrwxrwx 1 root root 4878 Jul 30 11:31 /opt/etc/my.cnf
```
解决方案：
```
[root@ttlsa ~]# chmod 644 /opt/etc/my.cnf
```
重新启动，ojbk
