---
title: Person Search深度自学笔记
date: 2018-12-07 13:55:18
tags:
mathjax: true
---

一些乱七八糟给自己看的东西，并不觉得有人会看😅

<!-- more -->

## Overview

行人搜索的工作主要是将行人检测（detection）以及行人重识别（Re-ID）整合在一起的工作。相比被广泛研究的单纯的行人重识别要更加贴近于现实的应用。

## Paper List of Person Search

|Paper|Source|Related Material|Rating|CUHK(mAP/Top-1)|PRW(mAP/Top-1)|
|:-:|:-:|:-:|:-:|:-:|:-:|
|A Discriminatively Learned Feature Embedding Based on Multi-Loss Fusion For Person Search|ICASSP 2018|-|✩|79.78/79.90|21.00/63.10|
|Correlation Based Identity Filter: An Efficient Framework for Person Search|ICIG 2017|-|✩✩|43.35/50.48|-|
|Joint Detection and Identification Feature Learning for Person Search|CVPR2 017|[Code](https://github.com/ShuangLI59/person_search)|✩✩✩|75.5/77.9|-|
|Enhanced Deep Feature Representation for Person Search|CCCV 2017|-|✩|77.8/80.6|-|
|IAN: The Individual Aggregation Network for Person Search|PR 2019|-|✩|77.23/80.45|-|
|Instance Enhancing Loss: Deep Identity-Sensitive Feature Embedding For Person Search|ICIP 2018|-|✩✩|79.43/79.66|24.26/69.47|
|Neural Person Search Machines|ICCV 2017|-|✩✩|77.9/81.2|24.2/53.1|
|Person Re-identification in the Wild|CVPR 2017|[Baseline](https://github.com/liangzheng06/PRW-baseline)|✩✩|-|20.5/48.3|
|Person Search by Multi-Scale Matching|ECCV 2018|-|✩✩|87.2/88.5|38.7/65.0|
|Person Search via A Mask-Guided Two-Stream CNN Model|ECCV 2018|-|✩✩|83.0/83.7|32.6/72.1|
|Person Search in a Scene by Jointly Modeling People Commonness and Person Uniqueness|ACM MM 2014|-|✩✩|-|-|
|RCAA: Relational context-aware agents for person search|ECCV 2018|-|✩✩|79.3/81.3||
|End-to-End Detection and Re-identification Integrated Net for Person Search|ACCV 2018|-|✩|79.5/81.5|25.6/48.7|
|Learning Context Graph for Person Search|CVPR 2019|[Code](https://github.com/sjtuzq/person_search_gcn)|✩✩✩|84.1/86.5|33.4/73.6|
|Query-guided End-to-End Person Search|CVPR 2019|[Home](https://github.com/munjalbharti/Query-guided-End-to-End-Person-Search)|✩✩✩|88.9/89.1|39.1/80.0|
|Partially Separated Networks for Person Search|PCM 2018|-|✩✩|86.8/89.1|30.0/53.3|
|A cascaded multitask network with deformable spatial transform on person search|IJARSys 2019|-|✩✩|84.1/84.5|34.3/68.4|
|Multilevel Collaborative Attention Network for Person Search|ACCV 2018|-|✩✩|76.3/79.2|29.1/60.1|
|Enhancing Person Retrieval with Joint Person Detection, Attribute Learning, and Identification|PCM 2018|-|✩|-|24.8/65.5|
|Spatial Invariant Person Search Network|PRCV 2018|[Code](https://github.com/liliangqi/person_search)|✩✩|85.3/86.0|39.5/59.2|
|FMT: fusing multi-task convolutional neural network for person search|MTAP 2019|-|✩|77.15/79.83|-|
|Segmentation Mask Guided End-to-End Person Search|Image Communication 2020|[Dataset](https://github.com/Dingyuan-Zheng/maskPS)|✩✩|86.3/86.5|26.7/64.0|
|DHFF: Robust Multi-Scale Person Search by Dynamic Hierarchical Feature Fusion|ICIP 2019|-|✩✩|90.2/91.7|41.1/70.1|
|Comprehensive Samples Constrain for Person Search|VCIP 2018|-|✩|81.5/81.8|-|
|Fast Person Search Pipeline|ICME 2019|-|✩✩|86.99/89.87|44.45/70.58|
|End-To-End Person Search Sequentially Trained On Aggregated Dataset|ICIP 2019|-|✩✩|79.4/80.5|29.4/31.9|
|Scale Voting With Pyramidal Feature Fusion Network for Person Search|IEEE Access 2019|-|✩✩|84.5/89.8|34.3/73.9|
|Structure-aware person search with self-attention and online instance aggregation matching|Neurocomputing|[Code](https://github.com/gggcy/person_search)|✩|76.98/77.86|-|
|Knowledge Distillation for End-to-End Person Search|arXiv|-|✩✩|85.0/85.5|-|
|Re-ID Driven Localization Refinement for Person Search|ICCV 2019|-|✩✩✩|93.0/94.2|42.9/70.2|
|Person Search Based on Improved Joint Learning Network|CASE 2019|-|✩|84.1/84.6|37.6/71.1|
|Dynamic imposter based online instance matching for person search|PR 2019|-|✩✩|83.8/84.6|30.4/71.5|
|Person Search with Joint Detection, Segmentation and Re-identification|HCC 2019|-|✩✩|-|24.35/53.73|
|Improving Person Search by Adaptive Feature Pyramid-based Multi-Scale Matching|VCIP 2019|-|✩✩|81.2/81.5|-|
|Person Search Based on Attention Mechanism|ISCIT 2019|-|✩|78.9/81.9|-|
|Hierarchical Online Instance Matching for Person Search|AAAI 2020|[Code](https://github.com/DeanChan/HOIM-PyTorch)|✩✩✩|89.7/90.8|39.8/80.4|
|Person Search by Separated Modeling and A Mask-Guided Two-Stream CNN Model|TIP 2020|-|✩✩|83.3/83.9|32.8/72.1|
|Person Search via Deep Integrated Networks|ApplSci 2020|-|-|-|-|
|Improved Model Structure with Cosine Margin OIM Loss for End-to-End Person Search|MMM 2020|-|✩✩|83.5/84.8|32.8/72.2|
|Norm-Aware Embedding for Efficient Person Search|CVPR 2020|-||||
|Efficient Person Search via Expert-Guided Knowledge Distillation|TCYB 2019|-|✩✩|91.1/91.9|34.5/59.9|
|An Iterative ***unsupervised*** Person Search Algorithm on Natural Scene Images|CAC 2019|-|✩✩|41.14/40.93|21.74/35.97|
|GAN-based person search via deep complementary classifier with center-constrained Triplet loss|PR 2020|-|✩|77.89/78.34|53.09/70.39|
|Robust Partial Matching for Person Search in the Wild|CVPR 2020|-|✩✩✩|88.9/89.3|41.9/81.4|
|End-to-End Thorough Body Perception for Person Search|AAAI 2020|-|✩✩|88.4/90.5|48.5/87.9|

Description of the rating$^{*}$:

* ✩ = Lack of Innovation
* ✩✩ = Inspiring
* ✩✩✩ = Insightful

\* According to personal opinion

## Related Paper List

|Paper|Source|Related Material|
|:-:|:-:|:-:|
|Fusion-Attention Network for person search with free-form natural language|PRL 2018|-|
|Cascade Attention Network for Person Search: Both Image and Text-Image Similarity Selection|arXiv|-|
|Deep Adversarial Graph Attention Convolution Network for Text-Based Person Search|ACM MM|-|
|Language Person Search with Mutually Connected Classification Loss|ICASSP 2019|-|
|Improving Text-Based Person Search by Spatial Matching and Adaptive Threshold|WACV 2018|-|
|Person Search in Videos with One Portrait Through Visual and Temporal Links|ECCV 2018|[Home](http://qqhuang.cn/projects/eccv18-person-search/) [Code](https://github.com/hqqasw/person-search-PPCC)|
|Person Search with Natural Language Description|CVPR 2017|[Code](https://github.com/ShuangLI59/Person-Search-with-Natural-Language-Description)|


## Dataset

该领域主要只有两个数据集 **[PRW](http://www.liangzheng.com.cn/Project/project_prw.html)** 以及 **[CUHK-SYSU](http://www.sysu-hcp.net/resources/)**

基于这两个数据集，有工作对部分行人图像进行了[mask标注](https://github.com/Dingyuan-Zheng/maskPS)

## Docker Image for JDI-PS

* 首先拉取Docker镜像：https://hub.docker.com/r/4f5da2/person_search
* 在准备数据集和代码， 并对代码进行一下修改
    * 在`tools/demo.py`中的`import matplotlib`下添加`matplotlib.use('Agg')`来避免对GUI相关功能的调用（因为是在docker里）
    * 由于protobuf版本发生变化，需在`lib/fast_rcnn/train.py`中增加一行`import google.protobuf.text_format`
    * 按照Github上对应的readme进行编译，填入docker镜像中cuDNN的路径如下：`cmake .. -DUSE_MPI=ON -DCUDNN_INCLUDE=/usr/include -DCUDNN_LIBRARY=/usr/lib/x86_64-linux-gnu/libcudnn.so`
* 编译Caffe框架并进行训练

