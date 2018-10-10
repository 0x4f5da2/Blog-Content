---
title: Mark↓语法笔记
date: 2018-04-07 13:55:18
tags:
---

总是忘Markdown的语法，写篇博客总结一下

 ~~于是又水了一篇博客(￣▽￣)"~~

 <!--more-->

## 标题

### 代码

```markdown
# h1
## h2
### h3
#### h4
##### h5

h1
===
h2
---
```

### 效果

> # h1
>
> ## h2
>
> ### h3
>
> #### h4
>
> ##### h5
>
> h1
> ===
> h2
> ---

## 引用

引用支持嵌套，注意引用的行与行之间要空一行，要不然还是会连在一起。 ~~（VSCode写的时候是这样的，然而好像你们看到的并不会）~~

### 代码 

```
> 苟利国家生死已
>
> 岂因祸福趋避之
> ——林则徐
```

### 效果

> > 苟利国家生死已
> > 
> > 岂因祸福趋避之
> > ——林则徐

## 代码片段

### 代码

```
使用`rm -rf /`命令来获得一个女朋友（误）
```

### 效果

> 使用`rm -rf /`命令来获得一个女朋友（误）

## 代码块

使用三个反引号或者三个波浪号开启或关闭代码块

### 代码

~~~
```c++
#include<iostream>
int main() {
    std::cout << "萌豚废宅想要女朋友" << std::endl;
    return 0;
}
```
~~~

### 效果

* C++
```c++
#include<iostream>
int main() {
    std::cout << "萌豚废宅想要女朋友" << std::endl;
    return 0;
}
```

## 链接

### 代码

```
[Github](https://www.github.com "最大的同性交友网站")
[blog][1]
[1]: https://0x4f5da2.github.io "My blog"
```

### 效果

> [Github](https://www.github.com "最大同性的交友网站")
> 
> [blog][1]
>
> [1]: https://0x4f5da2.github.io "My blog"

## 图片

### 代码

```
![](./images/favicon-32x32-next.png "description")
```

### 效果

> ![](./images/favicon-32x32-next.png "description")


## 带有链接的图片

### 代码

```
[![](./images/favicon-32x32-next.png "description")](https://www.github.com)
```

### 效果

> [![](./images/favicon-32x32-next.png "description")](https://www.github.com)


## 序表

在VSCode里`1.`显示的是序号，不知道这边怎么又不太对了

### 代码

```
* one
    * two
    * three
* four 
    1. five
    1. six
    1. seven
```

### 效果

> * one
>     * two
>     * three
> * four 
>    1. five
>    1. six
>    1. seven

## 序表中的代码块

### 代码

```
* code

        CryptoJS.AES.encrypt(word,pwd).toString();
```

### 效果

> * code
> 
>         CryptoJS.AES.encrypt(word,pwd).toString();


## 表格

### 代码

```
| a | b | c |
|:-------:|:- | ----------:|
| 居中 | 左对齐 | 右对齐 |
|=========|=============|==============|
```

### 效果

> | a | b | c |
> |:-------:|:- | ----------:|
> | 居中 | 左对齐 | 右对齐 |
> |=========|=============|==============|

## 杂七杂八

这边斜体好像也不太对了(⊙﹏⊙)


### 代码

```
*斜体*
_斜体_
**加粗**
***加粗+斜体***
**_加粗+斜体_**
~~删除线~~
Z<sup>a</sup>
Z<sub>a</sub>
<kbd>Ctrl</kbd>
***
* * *
---
<@xxx.com>
```

### 效果

> *斜体*
>
> _斜体_
>
> **加粗**
> 
> ***加粗+斜体***
>
> **_加粗+斜体_**
> ~~删除线~~
>
> Z<sup>a</sup>
> 
> Z<sub>a</sub>
>
><kbd>Ctrl</kbd>
> 
> ---
> 
> ***
>
> * * *
>
> <xxx@xxx.com>




