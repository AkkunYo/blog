---
title: "centos本地编译frp"
date: 2024-12-02 20:36:00 +0800
excerpt: "本地已经提前将golang安装，CentOS安装 Golang GOPATH为/root/go GOROOT为/usr/lib/go 下载执行编译frp源码 各自目录编译好的frpc/frps"
categories: []
tags: []
cover: /upload/1048874.jpg
permalink: /archives/centosben-di-bian-yi-frp
---
本地已经提前将golang安装，[CentOS安装 Golang](https://www.zkyml.com/#/info/249)

GOPATH为`/root/go`

GOROOT为`/usr/lib/go`

下载执行编译frp源码
```
go get github.com/fatedier/frp

cd root/go/src/github.com/fatedier/frp/cmd/frps/

go build

cd root/go/src/github.com/fatedier/frp/cmd/frpc/

go build
```
各自目录编译好的frpc/frps
