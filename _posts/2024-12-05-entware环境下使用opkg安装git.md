---
title: "Entware环境下使用opkg安装git"
date: 2024-12-05 18:24:00 +0800
excerpt: "直接安装git会提示无法访问https,需要安装git-http"
categories: []
tags: []
cover: /upload/1061423.jpg
permalink: /archives/entwarehuan-jing-xia-shi-yong-opkgan-zhuang-git
---
直接安装git会提示无法访问https,需要安装git-http
```
opkg remove git

opkg install git-http
```
