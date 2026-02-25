---
title: "CentOS安装 Golang"
date: 2024-11-30 08:35:00 +0800
excerpt: "方法一：yum安装 可以使用 go env查看安装后的默认path配置,无需在进行export环境变量操作。 方法二：手动安装 下载资源并解压 手动方法需要自己配置环境变量 然后执行source /erc/prof..."
categories: []
tags: []
cover: /upload/930715.png
permalink: /archives/centosan-zhuang-golang
---
#### 方法一：yum安装
```
yum install epel -y

yum install go -y

#查看版本

go version
```
可以使用 go env查看安装后的默认path配置,无需在进行export环境变量操作。

#### 方法二：手动安装

下载资源并解压
```
wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz

tar -zxvf go1.12.5.linux-amd64.tar.gz -C /usr/lib

mkdir /root/go
```
手动方法需要自己配置环境变量
```
vi /etc/profile

export GOROOT=/usr/lib/go

export GOBIN=$GOROOT/bin

export GOPKG=$GOROOT/pkg/tool/linux_amd64

export GOARCH=amd64

export GOOS=linux

export GOPATH=/root/go

export PATH=$PATH:$GOBIN:$GOPKG:$GOPATH/bin
```
然后执行source /erc/profile或者重启生效
