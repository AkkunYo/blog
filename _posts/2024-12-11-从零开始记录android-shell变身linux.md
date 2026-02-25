---
title: "从零开始记录android shell变身linux"
date: 2024-12-11 01:17:00 +0800
excerpt: "手机：红米1td 系统：miui9/4.4.2 内存：1G RAM/4G ROM（现在应该没有比这更低的了吧） 要求：开发版固件，开启root权限 一、下载re管理器，打开root权限"
categories: []
tags: []
cover: /upload/551571.jpg
permalink: /archives/cong-ling-kai-shi-ji-lu-android-shellbian-shen-linux
---
手机：红米1td

系统：miui9/4.4.2

内存：1G RAM/4G ROM（现在应该没有比这更低的了吧）

要求：开发版固件，开启root权限

#### 一、下载re管理器，打开root权限

进入系统管家root位置，自动下载root卡刷包后重启生效，root成功。

下载re,给予root读写权限。

将脚本ocmp.sh放入`/data/entware.arm/ocmp/`下，给予777权限。

#### 二、安装entware环境

adb shell连接手机，执行以下命令
```
root@HM2013022:/ # /data/entware.arm/ocmp/ocmp.sh

=======================================================

(1) 安装OCMP

(2) 卸载OCMP

(3) 设置数据库密码

(4) 重置数据库

(5) 数据库自动备份

(6) 全部重置（会删除网站目录，请注意备份）

(7) 安装网站程序

(8) 网站管理

(9) 开启Swap

(10) 开启 Redis

(11) 安装Entware环境

(0) 退出

输入你的选择[0-10]:

11
```
中间需要安装php组件，Y/N都可以，建议安装选Y

#### 三、将opt环境加入全局PATH,并开启虚拟内存swap
```
root@HM2013022:/ # vi /etc/mkshrc

#这里加入这两行,下面 place customisations是文件给的提示（关键）

[[ $PATH != "*/opt/bin*" ]] && PATH=$PATH:/opt/bin

[[ $PATH != "*/opt/sbin*" ]] && PATH=$PATH:/opt/sbin

#ls的alias命令也可以在该文件中设置好（可选）

if [ -f "/system/bin/ls" ];then

    rm /system/bin/ls

fi

alias l='ls'

alias la='l -a'

alias ll='l -lh'

alias lo='l -a -lh'



: place customisations above this line

:wq

#保存退出。开启swap，然后再执行安装OCMP

root@HM2013022:/ # /data/entware.arm/ocmp/ocmp.sh

=======================================================

(1) 安装OCMP

(2) 卸载OCMP

(3) 设置数据库密码

(4) 重置数据库

(5) 数据库自动备份

(6) 全部重置（会删除网站目录，请注意备份）

(7) 安装网站程序

(8) 网站管理

(9) 开启Swap

(10) 开启 Redis

(11) 安装Entware环境

(0) 退出

输入你的选择[0-10]:

9

----------------------------------------

|**************** SWAP ****************|

----------------------------------------

(1) 开启Swap

(2) 关闭Swap

(3) 删除Swap文件

输入你的选择[1-3]:

1
```
#### 四、安装OCMP

opt环境下的caddy+mysql+php。
```
root@HM2013022:/ # /data/entware.arm/ocmp/ocmp.sh

=======================================================

(1) 安装OCMP

(2) 卸载OCMP

(3) 设置数据库密码

(4) 重置数据库

(5) 数据库自动备份

(6) 全部重置（会删除网站目录，请注意备份）

(7) 安装网站程序

(8) 网站管理

(9) 开启Swap

(10) 开启 Redis

(11) 安装Entware环境

(0) 退出

输入你的选择[0-10]:

1
```
等待或者按提示操作，自动安装完成并生成ocmp全局命令。

#### 五、开机自启动设置（可选）
```
root@HM2013022:/ # chattr -ia /system/etc/install-recovery.sh

root@HM2013022:/ # cat /etc/install-recovery.sh

#在最后加入以下命令

sleep 60

#关闭selinux

setenforce 0

#开启telnetd，可无线连接

/system/xbin/busybox telnetd -l /system/bin/sh &

#挂载根目录为可读写

busybox mount -o remount,rw /

sleep 3

#挂载system目录为可读写

busybox mount -o remount,rw /system

#允许读写install-recovery.sh

chattr -ia /system/etc/install-recovery.sh

#opt环境需要/bin/sh

ln -s /system/bin/sh /bin/sh

mkdir -p /opt

#挂载entware搭配opt

mount -o bind /data/entware.arm /opt

sleep 1

mkdir -p /usr

mount -o bind /opt/usr /usr

sleep 1

mkdir -p /tmp

mkdir -p /opt/tmp

rm -rf /opt/tmp/*

mount -o bind /opt/tmp /tmp

sleep 1

#开机自动运行的脚本放在这个目录下，文件名不要带后缀格式名

#例如/system/etc/init.d/test是正确的

# (错误/system/etc/init.d/test.sh)

busybox run-parts /system/etc/init.d
```
#### 六、openssh的安装使用（可选）

[entware环境下使用opkg安装openssh和stfp](https://www.zkyml.com/#/info/251)
