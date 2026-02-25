---
title: "windows安装redis并设置开机启动服务"
date: 2024-12-10 08:15:00 +0800
excerpt: "redis官方下载地址：https://redis.io/download 解压后在reis文件夹内打开命令行，执行 即可运行成功。 如果设置开机启动，只需要将redis加入到windows服务即可"
categories: ["Windows"]
tags: ["windows"]
cover: /upload/1002831.jpg
permalink: /archives/windowsan-zhuang-redisbing-she-zhi-kai-ji-qi-dong-fu-wu
---
redis官方下载地址：[https://redis.io/download](https://redis.io/download)

解压后在redis文件夹内打开命令行，执行
```cmd
 redis-server.exe redis.windows.conf
```
即可运行成功。

***

如果设置开机启动，只需要将redis加入到windows服务即可
```cmd
redis-server.exe --service-install redis.windows-service.conf --loglevel verbose

redis-server.exe --service-start

#redis-server.exe --service-stop
```
