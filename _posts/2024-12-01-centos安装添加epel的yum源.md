---
title: "centos安装添加EPEL的yum源"
date: 2024-12-01 02:39:00 +0800
excerpt: "我们用yum安装软件时,经常发现我们的yum源里面没有该软件，需要自己去wget，然后configure,make,make install，太折腾了。 其实，CentOS还有一个源叫做 EPEL (Extra P..."
categories: []
tags: []
cover: /upload/947386.jpg
permalink: /archives/centosan-zhuang-tian-jia-epelde-yumyuan
---
我们用yum安装软件时,经常发现我们的yum源里面没有该软件，需要自己去wget，然后configure,make,make install，太折腾了。

其实，CentOS还有一个源叫做 EPEL (Extra Packages for Enterprise)，里面有1万多个软件，比163的源还强，强烈建议安装。
```
yum -y install epel-release
```
