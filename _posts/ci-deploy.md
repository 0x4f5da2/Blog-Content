---
title: 使用CI自动部署博客
date: 2018-10-15 17:40:19
tags:
---

经过了~~前几天~~一天的折腾，我的博客终于能够使用CI自动部署了，也就是说只要写Markdown文件并push到Github上特定的repo然后就可以部署上了😀

<!-- more -->

## Why CI ？

最开始的博客是在使用WSL中的NodeJS搭建的，之后重装了系统嫌麻烦，不想再装那一坨东西，所以写博客的事情就 ~~理所应当地~~ 一直被搁置了。从哪之后，就有个想法：要是只写Markdown剩下的都能够自动化就好了。实习之后接触到了CI，就又有了个想法，于是就有了可以自动化部署的博客和水的这篇博客。

感觉目前这种实践的最大的好处就是不受那些安装环境的狗逼事情的影响，只是专注在内容编写本身。即使换了一台新的电脑，也只需要一个Git。

## What is CI?

> 持续集成是一种软件开发实践，即团队开发成员经常集成他们的工作，通过每个成员每天至少集成一次，也就意味着每天可能会发生多次集成。每次集成都通过自动化的构建（包括编译，发布，自动化测试）来验证，从而尽早地发现集成错误。
> 
> ——百度百科

简单的来说就是在事先配置好的情况下（比如push到一个仓库），自动触发并执行预设的一连串操作（eg：编译，单元测试）

经过实践，发现使用过的Gitlab-CI和Travis-CI都是在执行CI的时候启动一个docker容器。然后在容器内完成对应的操作，CI脚本所使用的正是shell命令！

## How to CI？

之前实习的时候公司的代码是托管在内网自己搭建的Gitlab上的，不得不说Gitlab自带的CI/CD还是很好用的。调研了一圈发现Github上用的比较多到是Travis-CI，不过熟悉之后发现CI好像都是一个套路😂。

目前的做法是将Hexo博客中用来存放博文的_posts文件夹单独独立出来和`.travis.yml`一起，作为一个单独的仓库(Blog-Content)。而剩下的作为另外一个仓库(Blog-Hexo)。

经过多次的玄学翻车，配置文件最终完成的操作如下：
* 将两个仓库的内容合并
* 使用`sed`将Hexo的_config.yml中access_token替换为真正的Access Token
  ```yml
  # exmaple
  deploy:
    type: git
    repo: https://access_token@github.com/0x4f5da2/0x4f5da2.github.io.git
    branch: master
  ```
* 运行Hexo相关命令并部署

最后的`.travis.yml`如下，需要注意的是部分敏感信息需要放置在环境变量里面避免显式地使用，需要使用的时候用`${...}`引入。

```yml
language: node_js
node_js: stable
sudo: required
branches:
  only:
  - master
before_install:
- git clone https://${ACCESS_TOKEN}@github.com/0x4f5da2/Blog-Hexo.git
- mkdir Blog-Hexo/source
- cp -r _posts Blog-Hexo/source
- npm install -g hexo-cli
install:
- cd Blog-Hexo
- npm install
- npm install hexo-deployer-git --save
script:
- hexo clean
- hexo generate
after_script:
- git config --global user.name "${GIT_NAME}"
- git config --global user.email "${GIT_EMAIL}"
- sed -i "s/access_token/${ACCESS_TOKEN}/g" ./_config.yml
- hexo deploy
```

然后，每次在向Blog-Content仓库push的时候，就能够自动地部署了

--- 

## 更新

之后又加上了coding.net的CI部署，具体的信息可以看Github上对应仓库的`.travis-ci.yml`