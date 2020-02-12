---
title: 第一篇博客
date: 2018-03-25 22:55:00
tags:
mathjax: true
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

---

### 时隔不知道多久的更新

现在的博客相比现在各位看到了又有了一些微小的更新，有些时看得见的，比如评论；有些是看不见的，比如CI部署。CI部署已经有一篇了，然后就简单的写一下评论吧。主要还是怕之后忘。

#### 开启评论

Hexo的Next主题本身就自带评论，只要进行简单的配置就OK了。具体在`themes/next/_config.yml`中。找到使用<kbd>command/ctrl</kbd>+<kbd>F</kbd>查找`valine`相关字段进行设置就可以了。appid以及appkey可以在[LeanCloud](https://leancloud.cn/applist.html)注册一个开发者账号取得。

#### 多处部署 + 多线路解析

发现腾讯云有多线路解析的功能，也就是说可以根据用户的访问的地理位置，解析到不同的服务器上。折腾了半天又把博客部署到了coding.net的Pages服务上。然后把Github的Pages服务以及Coding.net的Pages服务分别设置为国外解析线路以及国内的解析线路。然而，一通操作之后，并没有快多少🌚。

#### 数学公式

修改next主题`_config.yml`中的`math`->`enable`为`true`。在每篇博客的markdown开头注释中设置`mathjax: true`开启对应页面的mathjax。将`math`->`per_page`设置为`false`使得每个页面加载mathjax（会降低渲染速度）

测试：

$$
x^2 + y^2 + z^2 = 1
$$

#### 图片支持

* 将`_config.yml`中的`post_asset_folder`设置为`true`

* 在Hexo目录下安装`hexo-asset-image`: `npm install hexo-asset-image --save`

* 测试：
    ![test_img](./first-blog/test_img.png "test")

