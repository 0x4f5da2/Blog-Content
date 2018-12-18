---
title: 深度自学笔记
date: 2018-12-07 13:55:18
tags:
---

一些乱七八糟的东西😅

<!-- more -->

## 论文

### Person Re-identification: Past, Present and Future

又着重看了一遍和行人搜索有关的内容

> jointly considering detection and re-ID confidence leads to higher person retrieval accuracy than using them separately

现有的端到端的工作只是将detection以及re-identification这两个集成到一块，距离最终所谓的“端到端”的解决方案还有很长的路要走

> pedestrian tracking is not mentioned nor have we known any existing works/datasets addressing the influence of tracking on re-ID. This work views it as an “ultimate” goal to integrate detection, tracking, and retrieval into one framework, and evaluate the impact of each module on the overall re-ID performance.

现在的有关Re-ID的研究过于的理想化，大多数的研究采用的是手工绘制的bounding boxes。因此……
 
 > Therefore, in an end-to-end re-ID system, it is critical that the impact of detection/tracking on re-ID be understood and that methods be proposed that detection/tracking methods/data can help re-ID.

基于哈希的方法在最近邻搜索的过程中是一个被广泛研究的解决方案，论文就该方法给予了一些启示，相关内容参见论文中Hashing-Based小结。

### Joint Detection and Identification Feature Learning for Person Search

一开始并没有发现这篇文章其实和arXiv上的“End-to-End...”那篇是同一篇文章，后来和师兄交流才知道😂

最开始不会配环境，把配套的代码跑起来还费了一番功夫（主要还是太菜了🌚），记录一下免得以后会用
* 使用docker镜像`nvidia/cuda:8.0-cudnn5-devel`搭建环境
* 换源，这里使用清华的源
    ```
    # 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse

    # 预发布软件源，不建议启用
    # deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
    ```
* 安装环境
    ```sh
    apt update

    apt install zsh curl git vim
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # caffe相关编译环境
    apt install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev libprotobuf-dev libboost-all-dev libatlas-base-dev libgflags-dev libgoogle-glog-dev liblmdb-dev cmake libopenmpi-dev unzip protobuf-compiler python-pip python-tk # caffe相关编译环境
    # 安装编译/运行时所需的Python库
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy cython easydict pyyaml protobuf opencv-python mpi4py matplotlib==2.2.3 scikit-image scikit-learn

    # 然后就可以按照readme里的说明编译
    ```
* 在`tools/demo.py`中的`import matplotlib`下添加`matplotlib.use('Agg')`来避免对GUI相关功能的调用（因为是在docker里）
* 由于protobuf版本发生变化，需在`lib/fast_rcnn/train.py`中增加一行`import google.protobuf.text_format`

