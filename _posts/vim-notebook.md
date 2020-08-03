---
title: VIM学习笔记
date: 2018-11-14 22:27:00
tags:
---

不想看论文，学习了一下VIM ~~简单来说就是把vimtutor的里的内容总结了一下(￣▽￣)"~~

<!-- more -->

* 使用`h`、`j`、`k`、`l`移动光标

* 使用`i`在反色字符前进行插入，使用`a`在反色字符后进行插入

* 使用`A`在整行后进行插入

* 使用`dw`删除光标字符开始后的一个单词，直到下个单词开始

* 使用`de`删除光标字符开始后的一个单词，直到空格

* 使用`d<n>w`删除光标字符开始后的n个单词，直到下个单词开始

* 使用`d<n>e`删除光标字符开始后的n个单词，直到空格

* 使用`d$`删除直到行尾的所有字符

* 使用`dd`删除一行

* 使用`<n>dd`删除n行

* 使用`u`撤销操作

* 使用CTRL-R撤销撤销操作

* 使用`p`放回使用`dd`删除的内容

* 使用`r<key>`将反色字符用`<key>`替换

* `ce`等效于`dei`，`c$`等效于`d$i`

* CTRL-G显示光标位置信息

* `gg`跳转到开头，`G`跳转到结尾，`<n>G`跳转到第n行

* 使用`/<kw>`搜索kw

* 使用`%`匹配括号

* 有关查找和替换
    > To substitute new for the first old in a line type    :s/old/new
    > To substitute new for all 'old's on a line type       :s/old/new/g
    > To substitute phrases between two line #'s type       :#,#s/old/new/g
    > To substitute all occurrences in the file type        :%s/old/new/g
    > To ask for confirmation each time add 'c'             :%s/old/new/gc

* 使用`:w FILENAME`保存

* 使用`:r FILENAME`读取文件并插入

* 使用`o`在下面另起一行，使用`O`在上面另起一行

* 使用`v`选中内容，使用`y`复制内容，使用`p`粘贴内容

* 使用`yw`复制单词

* 使用CTRL-D在命令模式进行补全

* 使用CTRL-D在切换窗口

就先这样吧，以后再加😅