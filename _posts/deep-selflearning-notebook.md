---
title: 深度自学笔记(持续更新)
date: 2018-12-07 13:55:18
tags:
---

一些乱七八糟给自己看的东西，不及并没有别人会看😅

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

* 按照Github上对应的readme进行编译，填入docker镜像中cuDNN的路径如下：`cmake .. -DUSE_MPI=ON -DCUDNN_INCLUDE=/usr/include -DCUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so`

### Neural Person Search Machine

* 不同于原先的“两步式”的方法，提出了一种递归缩减画面中的查找范围的一种方法

> selectively shrink its focus from a loose region to a tighter one containing the target automatically

* 论文中的方法基于“目标”在一幅画面中只有一个这个简单的假设，因此使用又粗到细地搜索“目标”可能会出现的地方可能会是一种更加高效的方法

* contributions:
    * robust to distracting factors
    * redefine the person search process
    * propose a new neural search model that can guide the model to reucrsively focus on the effective regions

* 论文中 ~~批判~~ 提及了 *Person
re-identification in the wild.* 以及 *Joint detection and identification feature learning for person search.* 

> these two works simply focus on how the interplay of pedestrian detection and person re-identification affects the overall performance, and they still isolate the person search into two individual components (detection and re-identification), which would introduce extra