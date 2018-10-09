---
title: 第一篇博客
date: 2018-03-25 22:55:00
tags:
---
折腾了一个周末，我陈某人总算是有自己的博客了。折腾的过程很不顺利，犯了很多很蠢的错误（主要还是自己太菜）。

然后，下面简单记录一下折腾的过程 ~~（主要还是怕以后忘了）~~ (￣▽￣)"

<!--more-->

使用的是`bash on windows`,不得不说windows的子系统在某些时候还是很方便的

#### 装node

最开始用的是`sudo apt-get install nodejs`来安装的node。不过好像是因为`apt-get`安装的版本太老了。后面出了很多的问题。最后是从官网上下载了`.tar.gz`文件进行安装的，过程差不多就是下面的样子：

```
cd ~
tar -xvf node-v8.10.0-linux-x64.tar.xz
sudo ln -s /home/chenzhicheng/node-v8.10.0-linux-x64/bin/node /usr/local/bin/
sudo ln -s /home/chenzhicheng/node-v8.10.0-linux-x64/bin/npm /usr/local/bin/
```

#### 装hexo

弄好了nodejs，安装hexo那会就比较的顺利了:

```
sudo npm install hexo-cli -g
hexo init blog
cd blog
npm install
hexo server
```

然后就可以通过`localhost:4000`访问博客了(～￣▽￣)～


#### 折腾主题

装完hexo之后发现默认的主题真的是太丑了，然后开始折腾起了主题。(⊙﹏⊙)

经过一番搜索之后，最后选定了[NexT.Gemini](https://github.com/theme-next/hexo-theme-next)

然后，觉得室友的的博客里动态的背景很不错，又折腾起了动态背景

~~（感觉自带的那些烂大街了,都在用，不符合我的审美，拒绝使用）~~

~~（在折腾主题的路上越走越远）~~

又经过一番搜索之后，觉得`particles.js`的效果不错，最重要的是它还可以[自定义](https://vincentgarreau.com/particles.js)符合我的审美的样式

一开始不知道在该怎么弄 ~~（我只是个小菜鸡，为什么要我弄这么高深的东西）~~ 。经过一番~~尝试摸索~~xjb试之后，发现大概是下面的样子 

* 把`particles.js`以及从[某网站](https://vincentgarreau.com/particles.js)上获得的`particlesjs-config.json`放到`blog/themes/next/source/js/src/`下面

* 在`blog/themes/next/layout/_layout.swig`中的`</body>`标签前加上下面的内容：
```html
<div id="particles-js" style="position: fixed; top: 0px; left: 0px; z-index: -1; width: 100%; height: 100%"></div>
<script src="/js/src/particles.js"></script>
<script>particlesJS.load('particles-js', '/js/src/particlesjs-config.json')</script>
```

至此，我的~~狂拽炫酷吊炸天~~简陋的博客就呈现在你们面前了