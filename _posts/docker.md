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
* 主机的内核与容器共享
* 容器中的进程与主机自身等价

<!-- more -->

<span class="bb_spoiler"><span>有点累了先休息一会 (￣▽￣)".....然后休息了好几个月，自从学了一些基础的命令之后觉得没有什么用就放在了一边 <del>借口</del>）😅</span></span>

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

### 挂载卷

还有两种方法进行卷挂在来着，但是因为现在主要炼丹，并用不到，还是下面的更加常用一些

```sh
docker run -v /host/dir:/container/dir debian
```

### 将docker镜像保存成tar文件

```sh
docker save -o [文件名] [镜像名]
```

### 加载保存成文件的docker镜像

```sh
docker load -i [文件名]
```

### 将容器提交成为镜像

```sh
docker commit -m "commit message" -a "author info" <container_id> [<repostory>[/<tag>]]
```

### 直接将容器到处至tar

```sh
docker export [container name] > [file name]  # 使用docker import倒入
```

### 暂停容器

```sh
docker pause <container_id>  # 暂停容器中的所有进程
docker unpause <container_id>  # 重启
```

暂停容器内所有的进程，容器中的进程不会收到任何信号。在Linux底层使用cgroup freezer功能实现。

### 容器的attach以及detach

```sh
docker attach <container_id>  # attach到一个容器中
# attach到容器中后，使用CTRL-C会终止正在运行的进程
# 若要detach，需要使用CTRL-P CTRL-Q
```

### docker账户相关文件位置

~/.docker/config.json

### 在docker中使用摄像头或者其他设备

```sh
# 以摄像头为例子
docker run -it --device /dev/video0 ubuntu:16.04 /bin/bash
```

之后就可以在docket容器中愉快地调用摄像头啦

### 端口相关

```sh
docker run -P -d radis  # 在host开一个高端口映射到容器中

docker port <container_id>  # 查看已分配的端口
```

### 其他

```sh
docker top <container_id>  # 类似ps，至显示容器内的进程，默认`-ef`
docker tag <container_id> <new_name>
docker log [-t] [-f] <container_id/container_name>  # -t timestamp, -f stream log
```

一些需要注意的问题
---

* 在使用Dockerfile进行构建的时候，最好将Dockerfile以及相关文件放进一个目录中。这样做的原因是Docker在进行构建的时候会把Docker所在的目录打包成为一个tar文件，传递给Docker的守护进程。

* 基础镜像一般会包含安全补丁，因此应当定时更新