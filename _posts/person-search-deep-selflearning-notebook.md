---
title: 深度自学笔记(Person Search)
date: 2018-12-07 13:55:18
tags:
---

一些乱七八糟给自己看的东西，并不觉得有人会看😅

<!-- more -->

## Overview

行人搜索的工作主要是将行人检测（detection）以及行人重识别（Re-ID）整合在一起的工作。相比被广泛研究的单纯的行人重识别要更加贴近于现实的应用。

## Paper List (Person Search)

|论文|来源|相关资料|
|:-:|:-:|:-:|
|A Discriminatively Learned Feature Embedding Based on Multi-Loss Fusion For Person Search|ICASSP 2018|-|
|Correlation Based Identity Filter: An Efficient Framework for Person Search|ICIG2017|-|
|Joint Detection and Identification Feature Learning for Person Search|CVPR2017|https://github.com/ShuangLI59/person_search|
|Enhanced Deep Feature Representation for Person Search|CCCV2017|-|
|Fusion-Attention Network for person search with free-form natural language|Pattern Recognition Letters 2018|-|
|IAN: The Individual Aggregation Network for Person Search|Pattern Recognition 2019|-|
|Instance Enhancing Loss: Deep Identity-Sensitive Feature Embedding For Person Search|ICIP2018|-|
|Neural Person Search Machines|ICCV2017|-|
|Person Re-identification in the Wild|CVPR2017|https://github.com/liangzheng06/PRW-baseline|
|Person Search by Multi-Scale Matching|ECCV2018|-|
|Person Search in Videos with One Portrait Through Visual and Temporal Links|ECCV2018|http://qqhuang.cn/projects/eccv18-person-search/ https://github.com/hqqasw/person-search-PPCC|
|Person Search via A Mask-Guided Two-Stream CNN Model|ECCV 2018|-|
|Person Search with Natural Language Description|CVPR2017|https://github.com/ShuangLI59/Person-Search-with-Natural-Language-Description|
|Transferring a Semantic Representation for Person Re-Identification and Search|CVPR2015|-|
|Cascade Attention Network for Person Search: Both Image and Text-Image Similarity Selection|arXiv|-|

## Additional Paper List

* **Beyond frontal faces: Improving person recognition using multiple cues.**

## Dataset

该领域主要只有两个数据集 **PRW** 以及 **CUHK-SYSU**

看论文的时候还看到了 **CAMPUS** 以及 **EPFL**，好像是比较小的数据集，还没有仔细去看

## Additional Material

* https://github.com/Cysu/open-reid

## Selected Paper Note

### Person Re-identification: Past, Present and Future

这篇文章是有关Re-ID的文献综述

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
    ```sh
    docker run --runtime=nvidia -it --name="person_search" -v ~/DockerVolume/person_search:/root/person_search nvidia/cuda:8.0-cudnn5-devel /bin/bash
    ```

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

* 上述过程可以被看作是一连串的建模过程

> Learning to search for a person from a big region to a spe- cific person region within the gallery image can be deemed as a sequence modeling problem.

### Person Search in Videos with One Protrait Through Visual and Temporal Links

感觉这篇文章所研究的问题和原先的论文所研究的问题有些许不同。论文中使用的是一个肖像照的图片。然后根据视觉线索以及时空联系来搜索对应的人。此外，论文提出了一个较为庞大的数据集：**CSM（Cast Search in Movie）**。

> However, they (re-identification and person recognition) are substantially different from the problem of **person search with one portrait**, which we aim to tackle in this work.



~~传统~~普通的行人搜索，待搜索图片能够很好地代表照片库中地普遍的情况(论文原话)。因此，基于视觉的方法能够表现出较为良好的性能。

本文工作的主要的难点在于消除单一的肖像照以及多样的照片库的差距,所使用的并不只是基于视觉的方法。

> Hence, for both problems, the references in the gallery are often good representatives of the targets, and therefore the methods based on visual cues can perform reasonably well.

>  Our task is to bridge a single portrait with a highly diverse set of samples, which is much more challenging and requires new techniques that go beyond visual matching.

使用的是一种标签传递的方法，基本的思路是利用人物在帧间的领接关系（temporal links）以及视觉上的相似的关系（visvual links），是的对应的人的身份信息（identity information）能够广泛地传播。

挑战：身份信息在大数据集上传播的可靠性

* 贡献
    * 系统性地研究了行人搜索在视频中的应用
    * 提出了一个将视觉相似度（visual similarity）以及时空联系（temporal links / tracklet）结合在一起考虑的框架，能够进行更进一步（？）的搜索
    * 提高了身份传播（？）的可靠性
    * 制作**CSM**（Csat Search in Movies）数据集

文章在Related Work中提到了**Label Propogation (Graph Transduction)**，该方法被广泛地应用于半监督的学习方法，是本文的主要理论基础之一。

> It relies on the idea of building a graph in which nodes are data points (labeled and unlabeled) and the edges represent similarities between points so that labels can propagate from labeled points to unlabeled points.


* CSM Dataset：
    * 由大量电影中的片段组成
    * 在尺度，光照，长度等方面都较为多样，很有挑战性
    * Query Set 由 IMDB 上的演员的肖像照骗组成，去一部影片中的前十位演员


