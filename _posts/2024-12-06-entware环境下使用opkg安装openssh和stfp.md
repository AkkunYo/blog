---
title: "entware环境下使用opkg安装openssh和stfp"
date: 2024-12-06 02:53:00 +0800
excerpt: "一、openssh-serve安装和使用 1.openssh-serve服务端 服务端用于被其他ssh客户端连接 首先下载openssh，并设置root密码 如果本机ip为192.168.31.12，使用其他设备连..."
categories: []
tags: []
cover: /upload/1113143.jpg
permalink: /archives/entwarehuan-jing-xia-shi-yong-opkgan-zhuang-opensshhe-stfp
---
### 一、openssh-serve安装和使用

#### 1.openssh-serve服务端

服务端用于被其他ssh客户端连接

首先下载openssh，并设置root密码
```shell
root@HM2013022:/ # opkg install openssh-server openssh-client openssh-sftp-server

root@HM2013022:/ # passwd root

>123456

root@HM2013022:/ # vi /opt/etc/ssh/sshd\_config

HostKey ~/.ssh/id\_rsa

PermitRootLogin yes

PubkeyAuthentication yes

#AuthorizedKeysFile .ssh/authorized\_keys

PasswordAuthentication yes

#GSSAPIAuthentication no

#GSSAPICleanupCredentials yes

Subsystem sftp /opt/lib/sftp-server

#然后重启即可

root@HM2013022:/ # /opt/etc/init.d/S40sshd restart
```
如果本机ip为192.168.31.12，使用其他设备连接的方式
```shell
root@wee:/ # ssh root@192.168.31.12

>123456（上文passwd设置的密码）
```
连接成功

如果要加密钥认证，将PasswordAuthentication yes改为no

#### 2.openssh-client客户端

客户端用于连接其他ssh服务器
```shell
root@HM2013022:/ # vi /opt/etc/ssh/ssh\_config

#修改此配置即可

StrictHostKeyChecking no
```
### 二、openssh环境变量设置

连接openssh后运行 env ，发现PATH不包含安卓原有的PATH（比如/system/bin 一类的）。

默认运行的sh位置是/opt/bin/sh，如果需要替换自己喜欢的sh类型,可以替换/opt/bin/sh（做好备份）。
```shell
root@HM2013022:/ # vi /opt/etc/profile

is\_substring(){

case "$2" in

*$1*) return 0;;

\*) return 1;;

esac

}

# Set CHECK\_OPT\_PATH to 1 to check /opt/bin and /opt/sbin in PATH

CHECK\_OPT\_PATH=1

if [ $CHECK\_OPT\_PATH = 1 ]; then

is\_substring "/opt/bin" $PATH

[ $? == 1 ] && export PATH=/opt/bin:$PATH

is\_substring "/opt/sbin" $PATH

[ $? == 1 ] && export PATH=/opt/sbin:$PATH

is\_substring "/system/sbin:/system/bin:/system/xbin" $PATH

[ $? == 1 ] && export PATH=/system/sbin:/system/bin:/system/xbin:$PATH

else

export PATH=/opt/bin:/opt/sbin:$PATH

fi

export TERMINFO=/opt/share/terminfo

export TERM=xterm

export TMP=/opt/tmp

export TEMP=/opt/tmp

unset LD\_PRELOAD

unset LD\_LIBRARY\_PATH

alias mc="mc -c"

if [ -f "/system/bin/ls" ];then

rm /system/bin/ls

fi

alias l='ls'

alias la='l -a'

alias ll='l -lh'

alias lo='l -a -lh'

# You may define localization

#export LANG='ru\_RU.UTF-8'

#export LC\_ALL='ru\_RU.UTF-8'

export LANG='en\_US.UTF-8'

export LC\_ALL='en\_US.UTF-8'
