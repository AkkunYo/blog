---
title: "git提交进行code review"
date: 2022-10-14 08:34:00 +0800
excerpt: "git提交进行code review"
categories: ["Android"]
tags: ["git"]
cover: https://images7.alphacoders.com/805/805824.jpg
permalink: /archives/1697078260155
---
# **git提交进行code review**
```
//git push [远程主机] [本地分支]:[远程分支]

//refs/for表示需要进行code review才能合并
git push origin master:refs/for/master

//refs/heads表示不需要code review,直接合并
git push origin master:refs/heads/master
```
