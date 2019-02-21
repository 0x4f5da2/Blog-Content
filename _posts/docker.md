---
title: Docker学习笔记
date: 2018-06-10 23:12:19
tags:
---
<style type="text/css">
span.bb_spoiler {
	color: #000000;
	background-color: #000000;
	padding: 0px 8px;
}

span.bb_spoiler:hover {
	color: #ffffff;
}

span.bb_spoiler > span {
	visibility: hidden;
}

span.bb_spoiler:hover > span {
	visibility: visible;
}
</style>

容器
---

* 容器是对应用程序及其依赖关系的封装
* 轻量
* 容器能与操作系统共享资源，因此其效率高出一个数量级
* 容器的性能损耗非常低
* 容器具有可移植性
* 容器适用于微服务架构

<!-- more -->

有点累了先休息一会 (￣▽￣)".....

<span class="bb_spoiler"><span>然后休息了四个月（更新于2018.10.11、自从学了一些基础的命令之后觉得没有什么用就放在了一边 ~~借口~~）😅</span></span>

暑假实习的时候有接触了一些docker相关的内容，算是有了一些实战经验，然后总结了一下

一些常用的操作
---

### dockerfile

简单的来说就是用来构建镜像的时候用的，下面是一个制作带有`kubectl`命令的简单的例子：

```dockerfile
FROM ubuntu:16.04
RUN apt update
RUN apt -y install python3
COPY ./kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
COPY ./config /root/.kube/config 
```

然后，使用如下的docker命令来构建镜像（Windwos）

```bat
set IMAGE=<image_name, tag and etc.>
docker build -t %IMAGE% .
docker push %IMAGE%
```


### 在docker容器以及host之间传输文件

* 使用`docker cp <path> <containerName>:<path>`从宿主机复制文件出来

* 使用`docker cp <containerName>:<path> <path>`从docker中复制文件出来

### docker without sudo

在ubuntu直接安装docker之后会出现docker命令需要使用sudo才能够执行的情况，然后在stackoverflow上找了一个有效的解决方法

```sh
sudo groupadd docker
sudo gpasswd -a $USER docker
# either
newgrp docker
# or 
sudo reboot
# end 
```

### Volume

```
docker run -v /host/dir:/container/dir debian
```

### 将docker镜像保存成tar文件

```sh
docker save -o [文件名] [镜像名]
```

### 将容器提交成为镜像

```sh
docker commit -m "commit message" -a "author info" <container_id> [<repostory>[/<tag>]]
```

### 加载保存成文件的docker镜像

```sh
docker load -i [文件名]
```

### 直接将容器到处至tar

```sh

docker export [container name] > [file name]
```


### docker账户相关文件位置

~/.docker/config.json

### 在docker中使用摄像头或者其他设备

```sh
# 以摄像头为例子
docker run -it --device /dev/video0 ubuntu:16.04 /bin/bash
```

之后就可以在docket容器中愉快地调用摄像头啦