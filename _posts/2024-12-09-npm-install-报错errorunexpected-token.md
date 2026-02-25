---
title: "npm install 报错ErrorUnexpected token"
date: 2024-12-09 02:41:00 +0800
excerpt: "npm install 运行后报错Unexpected token } in JSON at position 496532 while parsing 网上有清除cache和清除淘宝镜像链接的解决方法"
categories: []
tags: []
cover: /upload/1069735.jpg
permalink: /archives/1750304708347
---
npm install 运行后报错Unexpected token } in JSON at position 496532 while parsing

网上有清除cache和清除淘宝镜像链接的解决方法

但是无效。

最后方案：

删除`package-lock.json`

重新运行`npm install`

ok搞定
