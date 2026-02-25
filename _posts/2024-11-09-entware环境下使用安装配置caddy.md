---
title: "Entware环境下使用安装配置Caddy"
date: 2024-11-09 00:22:00 +0800
excerpt: "简单以代码操作来说明"
categories: ["Linux", "Android"]
tags: ["Android"]
cover: /upload/1019443.png
permalink: /archives/1733679075297
---
简单以代码操作来说明
```shell#curl https://getcaddy.com | bash -s personal http.cgi,http.filebrowser,http.git

[root@weekhigh ~]# wget http://kod.zkyml.com:8686/caddy -O /opt/bin/caddy

[root@weekhigh ~]# mkdir -p /opt/var/log/caddy

# 初始化caddy配置文件

[root@weekhigh ~]# wget http://www.yahei.net/tz/tz.zip -O /opt/share/www/default/tz.zip

[root@weekhigh ~]# unzip -o /opt/share/www/default/tz.zip -d /opt/share/www/default/

[root@weekhigh ~]# rm -rf /opt/share/www/default/tz.zip

[root@weekhigh ~]# mkdir -p /opt/etc/caddy/vhost

[root@weekhigh ~]# echo "import /opt/etc/caddy/vhost/*.conf" > /opt/etc/caddy/caddyfile

[root@weekhigh ~]# vi /opt/etc/caddy/vhost/default.conf

:8080 {

        root /opt/share/www/default

        tls off

        timeouts 60s

        gzip

        fastcgi / /opt/var/run/php7-fpm.sock php {

        index tz.php

    }

        log /opt/var/log/caddy/access.log

        errors /opt/var/log/caddy/error.log

}

:wq

# 添加启动服务

[root@weekhigh ~]# vi /opt/etc/init.d/S10caddy

#!/bin/sh

ENABLED=yes

PATH=$PATH:/opt/sbin:/opt/bin

PROCS=caddy

ARGS="-conf /opt/etc/caddy/caddyfile -log stdout -root /tmp -agree"

PREARGS=""

DESC=$PROCS

OPID=/opt/var/run/caddy.pid

. /opt/etc/init.d/rc.func

:wq

[root@weekhigh ~]# chmod -R 777 /opt/share/www/default

[root@weekhigh ~]# /opt/etc/init.d/S10caddy restart
```
