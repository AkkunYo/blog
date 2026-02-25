---
title: "JavaScript中click事件的拦截"
date: 2024-12-07 08:23:00 +0800
excerpt: "当子控件处理点击事件后，父控件点击事件不允许在进行 在普通js中可以通过return false拦截 当在函数中有出现'return false'时，表示事件处理阻止了默认的事件行为并停止了事件通过dom向上冒泡。"
categories: []
tags: []
cover: /upload/636977.jpg
permalink: /archives/javascriptzhong-clickshi-jian-de-lan-jie
---
当子控件处理点击事件后，父控件点击事件不允许在进行

在普通js中可以通过return false拦截
```
$('xxx').on('click', function() {

    xxx

    xxx

    ...

    return false;

});
```
当在函数中有出现'return false'时，表示事件处理阻止了默认的事件行为并停止了事件通过dom向上冒泡。

等价于
```
$('xxx').on('click', function(event) {

    ...

    ...

    event.preventDefault();//阻止事件的默认行为

    event.stopPropagation();//阻止该dom节点往上冒泡

})
```
如果是通过vuecli框架进行的,示例如下
```
<a href="javascript:void(0)"

onclick="javascript:event.preventDefault();event.stopPropagation();"

@click="$router.push('/admin/edit/'+articlebean.id)">编辑</a>
```
完成
