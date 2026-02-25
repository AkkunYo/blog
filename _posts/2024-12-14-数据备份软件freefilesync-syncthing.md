---
title: "数据备份软件FreeFileSync、Syncthing"
date: 2024-12-14 00:14:00 +0800
excerpt: "这2个软件只解决目录同步到远程或者备份到离线硬盘，没有或只有简单的版本控制，非常的轻量级，非常得专一。 FreeFileSync FreeFileSync用在离线备份，定期接上移动硬盘，打开同步方案，同步一下。Sy..."
categories: []
tags: []
cover: https://images2.alphacoders.com/961/961698.png
permalink: /archives/shu-ju-bei-fen-ruan-jian-freefilesync-syncthing
---
这2个软件只解决目录同步到远程或者备份到离线硬盘，没有或只有简单的版本控制，非常的轻量级，非常得专一。

## FreeFileSync

FreeFileSync用在离线备份，定期接上移动硬盘，打开同步方案，同步一下。Syncthing我用在在线远程备份。

- FreeFileSync可以保持2个文件夹同步，支持本地文件夹、网上邻居、FTP。

- 文件比较根据文件更新时间、大小（1T几分钟就可以检查完）,可以后台自动同步。

- 带简单的版本管理。

- 可以建立配置文件，保存多个同步方案。

- 使用非常简单，选择2个目录，检查不同，同步即可。

所以FreeFileSync就是一个copy的功能，你可以认为他就是一个增强型的copy。

为什么不用copy？拷贝黏贴也很简单，但是对于大量文件拷贝黏贴不靠谱，无法断点续传，遇到锁定文件可能出错。

拷贝黏贴只适合小量文件，习惯好的人一般会拷贝完检查一下源和目的文件夹的文件数量和大小。

## Syncthing

- Syncthing也是同步2个文件夹的，类似私有云的Dropbox，支持多台客户端实时双向同步，但是他不支持本地文件夹，只支持远程。

- 使用Go语言编写，绿色软件，下载后打开会打开一个浏览器页面，在里面做文件夹同步的配置。

- 只支持Android不支持iOS。

Syncthing会对文件做分块SHA-256 hash，类似BT协议，相同的block只传输一次。也就是如果你有2个文件很大一模一样只是文件名不同，实际上在网络上可能只会传输一次。如果你对一个大文件改名，运气好的话可能其他同步的客户端也不需要传输数据。而且基于BT协议，多个客户端之间可以互相传输加快传输速度。

传输过程是AES-128加密的，比网上邻居SMB（老版本的）、rsync（不走SSH）、FTP（非SFTP）安全一点，中间可以经过开放的relay服务器也不担心数据泄露。

配置简单，你可以依赖全局的一个dynamic发现服务器，也很安全，发现服务器只会知道你的IP地址，认证还是根据各个服务器自己的私钥。新增加一个同步客户端只要提交一串SHA-256的Device ID即可。

端口可自定义，不依赖网上邻居等有较大风险的端口。

#### 1.win安装

先从官网下载好对应版本的Syncthing，解压后直接运行syncthing.exe。

同时浏览器还会打开http://127.0.0.1:8384/这个网址，可以看到默认已经创建了一个默认文件夹yct7k-lrebo，所在路径为C:UsersAdministratorSync

#### 2.vps/linux安装
```
cd ~

wget https://github.com/syncthing/syncthing/releases/download/v0.14.5/syncthing-linux-amd64-v0.14.5.tar.gz

tar xzvf syncthing-linux-amd64-v0.14.5.tar.gz

rm -rf syncthing-linux-amd64-v0.14.5.tar.gz

cd syncthing-linux-amd64-v0.14.5

cp syncthing /usr/local/bin
```
#运行syncthing

`syncthing`

#编辑配置文件
```
vim ~/.config/syncthing/config.xml

<gui enabled="true" tls="false" debugging="false">

    <address>0.0.0.0:8384</address>

    <apikey>2GeGJK9z6tXKP3nHJYU56ZHoYSYnqQ9S</apikey>

    <theme>default</theme>

</gui>
```
#修改为0.0.0.0后保存退出，命令行运行，防火墙设置开启8384端口
```
iptables -I INPUT -p tcp --dport 8384 -j ACCEPT

service iptables save

service iptables restart

syncthing
```
再次打开http://your\_ip\_addr:8384就能看见管理页面了

可以很明显地看到一条警告信息，提醒我们设置管理用户及密码，点击「设置」，然后把「用户名」和「密码」填写好，「使用加密连接到图形管理页面」这个是开启HTTPS，按需勾选

云端设备ID获取：操作 -> 设备ID

### 同步

打开本地管理页面http://127.0.0.1:8384/，然后点击「添加远程设备」将VPS添加到同步列表里，其中「设备ID」需要在VPS的管理页面打开「操作」--「显示ID」查看，将ID复制到「设备ID」一栏中，「地址列表」默认使用dynamic即可，其他按需修改

保存之后我们可以在VPS端的管理页面上看见连接请求

添加成功后会有共享文件夹的提示

然后在本地同步文件夹中添加文件，vps/linux端会同步新增
