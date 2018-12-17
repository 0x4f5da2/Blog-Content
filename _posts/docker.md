---
title: Docker学习笔记
date: 2018-06-10 23:12:19
tags:
---

容器
---

* 容器是对应用程序及其依赖关系的封装
* 轻量
* 容器能与操作系统共享资源，因此其效率高出一个数量级
* 容器的性能损耗非常低
* 容器具有可移植性
* 容器适用于微服务架构

<!-- more -->

有点累了先休息一会 (￣▽￣)"

休息了四个月😅（2018.10.11），

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

### 将docker镜像保存成tar文件

```sh
docker save -o [文件名] [镜像名]
```

### 将容器提交成为镜像

```sh
docker commit -m "commit message" -a "author info" [container_id]
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