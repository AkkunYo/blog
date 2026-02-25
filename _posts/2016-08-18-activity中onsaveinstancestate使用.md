---
title: "Activity中onSaveInstanceState使用"
date: 2016-08-18 00:43:00 +0800
excerpt: "onSaveInstanceState()和onRestoreInstanceState()使用详解 onSaveInstanceState()和onRestoreInstanceState()的触发"
categories: ["Android"]
tags: ["Android"]
cover: /upload/465155.jpg
permalink: /archives/1750304757309
---
onSaveInstanceState()和onRestoreInstanceState()使用详解

### **onSaveInstanceState()和onRestoreInstanceState()的触发**

1. 如果是用户自动按下返回键，或程序调用finish()退出程序，是不会触发onSaveInstanceState()和onRestoreInstanceState()的。
2. 每次用户旋转屏幕时，您的Activity将被破坏并重新创建。当屏幕改变方向时，系统会破坏并重新创建前台Activity，因为屏幕配置已更改，您的Activity可能需要加载替代资源（例如布局）。即会执行onSaveInstanceState()和onRestoreInstanceState()的。

### **保存Activity状态**

当Activity开始停止时，系统会调用onSaveInstanceState()。此方法的默认实现保存有关Activity视图层次结构状态的信息，例如EditText小部件中的文本或ListView的滚动位置。

为了保存Activity的附加状态信息，需要实现onSaveInstanceState()并向对象添加键值对Bundle。

例如：
```
static final String STATE_SCORE = "playerScore";

static final String STATE_LEVEL = "playerLevel";

...

@Override

public void onSaveInstanceState(Bundle savedInstanceState) {

    // 保存用户自定义的状态

    savedInstanceState.putInt(STATE_SCORE, mCurrentScore);

    savedInstanceState.putInt(STATE_LEVEL, mCurrentLevel);



    // 调用父类交给系统处理，这样系统能保存视图层次结构状态

    super.onSaveInstanceState(savedInstanceState);

}
```
### **恢复Activity状态**

当Activity在之前被破坏后重新创建时，可以从Bundle系统通过您的Activity中恢复您的保存状态。这两个方法onCreate()和onRestoreInstanceState()回调方法都会收到Bundle包含实例状态信息的相同方法。

因为onCreate()调用该方法是否系统正在创建一个新的Activity实例或重新创建一个以前的实例，所以必须在尝试读取之前检查该Bundle状态是否为空。如果它为空，那么系统正在创建一个Activity的新实例，而不是恢复之前被销毁的实例。

例如，下面是如何恢复一些状态数据onCreate()：
```
 @Override

protected void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState); // 记得总是调用父类



    // 检查是否正在重新创建一个以前销毁的实例

    if (savedInstanceState != null) {

        // 从已保存状态恢复成员的值

        mCurrentScore = savedInstanceState.getInt(STATE_SCORE);

        mCurrentLevel = savedInstanceState.getInt(STATE_LEVEL);

    } else {

        // 可能初始化一个新实例的默认值的成员

    }

    ...

}
```
当然也可以选择执行onRestoreInstanceState()，而不是在系统调用onStart()方法之后恢复状态。系统onRestoreInstanceState()只有在存在保存状态的情况下才会恢复，不需要检查是否Bundle为空：
```
public void onRestoreInstanceState(Bundle savedInstanceState) {

    // 总是调用超类，以便它可以恢复视图层次超级

    super.onRestoreInstanceState(savedInstanceState);



    // 从已保存的实例中恢复状态成员

    mCurrentScore = savedInstanceState.getInt(STATE_SCORE);

    mCurrentLevel = savedInstanceState.getInt(STATE_LEVEL);

}
```
