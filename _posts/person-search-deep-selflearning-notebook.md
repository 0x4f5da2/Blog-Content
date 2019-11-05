---
title: 深度自学笔记(Person Search)
date: 2018-12-07 13:55:18
tags:
---

一些乱七八糟给自己看的东西，并不觉得有人会看😅

<!-- more -->

## Overview

行人搜索的工作主要是将行人检测（detection）以及行人重识别（Re-ID）整合在一起的工作。相比被广泛研究的单纯的行人重识别要更加贴近于现实的应用。

## Paper List of Person Search

|Paper|Source|Related Material|
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
|Person Search in a Scene by Jointly Modeling People Commonness and Person Uniqueness|ACM MM 2014|-|
|RCAA: Relational context-aware agents for person search|ECCV2018|-|
|End-to-End Detection and Re-identification Integrated Net for Person Search|ACCV2018|-|
|Learning Context Graph for Person Search|CVPR2019 Oral|https://github.com/sjtuzq/person_search_gcn|
|Query-guided End-to-End Person Search|CVPR2019|https://github.com/munjalbharti/Query-guided-End-to-End-Person-Search|
|Partially Separated Networks for Person Search|PCM2018|-|
|A cascaded multitask network with deformable spatial transform on person search|International Journal of Advanced Robotic Systems|-|
|Multilevel Collaborative Attention Network for Person Search|ACCV2018|-|
|Enhancing Person Retrieval with Joint Person Detection, Attribute Learning, and Identification|PCM2018|-|
|Spatial Invariant Person Search Network|PRCV2018|https://github.com/liliangqi/person_search|
|FMT: fusing multi-task convolutional neural network for person search|Multimedia Tools and Applications|-|
|Segmentation Mask Guided End-to-End Person Search|arXiv|-|
|Dhff: Robust Multi-Scale Person Search by Dynamic Hierarchical Feature Fusion|Image Processing 2019|-|
|Comprehensive Samples Constrain for Person Search|VCIP 2018|-|
|Fast Person Search Pipeline|ICME 2019|-|
|End-To-End Person Search Sequentially Trained On Aggregated Dataset|Image Processing|-|
|Scale Voting With Pyramidal Feature Fusion Network for Person Search|IEEE Access|-|
|Person Search System Using Clothing Features|Electronics and Communications in Japan|-|
|Structure-aware person search with self-attention and online instance aggregation matching|Neurocomputing|https://github.com/gggcy/person_search|
|Knowledge Distillation for End-to-End Person Search|arXiv|-|

## Paper of Interest List

|Paper|Source|Related Material|
|:-:|:-:|:-:|
|Attribute-based Person Retrieval and Search in Video Sequences|AVSS2018|-|
|Fast Open-World Person Re-Identification|Image Processing|-|
|Re-ID done right: towards good practices for person re-identification|arXiv|-|
|Weakly Supervised Person Re-Identification|CVPR2019|-|
|Multimodal clothing recognition for semantic search in unconstrained surveillance imagery|VCIP|-|
|Fusion-Attention Network for person search with free-form natural language|PRL|-|
|Cascade Attention Network for Person Search: Both Image and Text-Image Similarity Selection|arXiv|-|
|Deep Adversarial Graph Attention Convolution Network for Text-Based Person Search|ACM MM|-|
|Language Person Search with Mutually Connected Classification Loss|ICASSP 2019|-|
|Improving Text-Based Person Search by Spatial Matching and Adaptive Threshold|WACV 2018|-|


## Dataset

该领域主要只有两个数据集 **[PRW](http://www.liangzheng.com.cn/Project/project_prw.html)** 以及 **[CUHK-SYSU](http://www.sysu-hcp.net/resources/)**

## Docker Image for JDI-PS

做了docker镜像：https://hub.docker.com/r/4f5da2/person_search

### Reminders for the Docker Image

* 在`tools/demo.py`中的`import matplotlib`下添加`matplotlib.use('Agg')`来避免对GUI相关功能的调用（因为是在docker里）

* 由于protobuf版本发生变化，需在`lib/fast_rcnn/train.py`中增加一行`import google.protobuf.text_format`

* 按照Github上对应的readme进行编译，填入docker镜像中cuDNN的路径如下：`cmake .. -DUSE_MPI=ON -DCUDNN_INCLUDE=/usr/include -DCUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so`

## Additional Related Material

* https://github.com/Cysu/open-reid


