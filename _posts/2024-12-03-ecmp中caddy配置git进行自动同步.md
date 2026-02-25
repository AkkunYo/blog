---
title: "ECMP中caddy配置git进行自动同步"
date: 2024-12-03 00:02:00 +0800
excerpt: "git公开库的配置 这个简单粗暴，caddy配置文件中git模块的配置如下， 就是这么简单 git私库的配置 caddy配置文件中git模块的配置如下，要加ssh: 然后修改opt中ssh客户端的配置文件/opt/..."
categories: [运维]
tags: [Caddy, Git, 自动化部署]
cover: https://images2.alphacoders.com/697/697294.jpg
permalink: /archives/ecmpzhong-caddypei-zhi-gitjin-xing-zi-dong-tong-bu
---
### git公开库的配置

这个简单粗暴，caddy配置文件中git模块的配置如下，
```
git {

    repo https://github.com/xxx/blog

    branch master

    path /opt/share/www/default

    interval 60

    then chmod -R 777 /opt/share/www/default

}
```
就是这么简单

### git私库的配置

caddy配置文件中git模块的配置如下，要加ssh:
```
git {

    repo ssh://git@code.aliyun.com:123456/blog.git

    path /opt/share/www/blog

    interval 60

    then chmod -R 777 /opt/share/www/blog

}
```
然后修改opt中ssh客户端的配置文件`/opt/etc/ssh_config`
```
StrictHostKeyChecking no
```
ok，搞定
