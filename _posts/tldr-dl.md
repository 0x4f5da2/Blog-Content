---
title: TL;DR for DL
date: 2019-11-26 18:06:14
tags:
mathjax: true
---

自己炼丹时候总结的杂七杂八的东西 | My naive wiki for DL 😀

<!-- more -->

Numpy高级操作
---

https://docs.scipy.org/doc/numpy/reference/arrays.indexing.html

https://docs.scipy.org/doc/numpy/user/basics.broadcasting.html

numpy.where/argwhere多条件查询
---

```python
np.argwhere((mat > 0) and (mat < 1))
```

PyTorch中的numpy.argwhere的work around
---

```python
((ten > 0) + (ten < 1) == 2).nonzero()
```

PyTorch不同版本之间的一个小坑
---

1.0以后
```
Python 3.7.5 (default, Oct 31 2019, 15:18:51) [MSC v.1916 64 bit (AMD64)] :: Anaconda, Inc. on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> t = torch.randn(5,6)
>>> t > 0
tensor([[ True,  True,  True,  True,  True, False],
        [ True,  True,  True,  True,  True, False],
        [False,  True, False, False,  True,  True],
        [ True, False,  True,  True, False, False],
        [ True, False,  True,  True, False,  True]])
```

0.4.1以前
```
Python 3.7.5 (default, Oct 31 2019, 15:18:51) [MSC v.1916 64 bit (AMD64)] :: Anaconda, Inc. on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> t = torch.randn(5,6)
>>> t > 0
tensor([[0, 1, 1, 0, 1, 0],
        [1, 1, 1, 1, 1, 0],
        [1, 0, 0, 0, 0, 0],
        [0, 1, 0, 1, 1, 1],
        [1, 1, 0, 0, 0, 1]], dtype=torch.uint8)
```

Faster R-CNN中SmoothL1Loss相关内容
---

torchvision里的SmoothL1Loss是py-faster-rcnn中的所使用的SmoothL1Loss的一个特例。Faster R-CNN中使用的Loss的公式如下。

$$
f(x)=
\begin{cases}
0.5 \times\left(\operatorname{sigma}^{2} \times x\right)^{2} & if|x|<\frac{1}{\operatorname{sigma}^{2}} \\\\
|x|-0.5 / \operatorname{sigma}^{2} & {\text { otherwise }}
\end{cases}
$$

对于其中的其他参数，`bbox_inside_weights`用于控制只让正样本参与回归的计算，`bbox_outside_weights`起到公式中的$N_{reg}$的效果。

### 相关参考

* https://www.zhihu.com/question/65587875

* https://github.com/rbgirshick/caffe-fast-rcnn/blob/faster-rcnn/src/caffe/layers/smooth_L1_loss_layer.cu

卷积以及转置（反）卷积相关内容
---

https://arxiv.org/abs/1603.07285 中的第四章节讲得比较好 [\[pdf\]](1603.07285.pdf)

如何正确地为论文取一个题目
---

【研究目的】+【研究背景】：【研究方法】
如：Towards Cost-Efficient Content Placement in Media Cloud: Modeling and Analysis

研究目的：Towards Cost-Efficient Content Placement
研究背景：Media Cloud
研究方法：Modeling and Analysis

Pytorch DDP的一个小坑
---

* 需要使用DDP包装后的模型来初始化优化器（optimizer），这部分个人的理解是：不这样的话相当于是影响了DDP对于模型在多卡之间同步的封装，会带来出乎意料的结果。

* 对于`DistributedSampler`，需要在每个epoch之前进行`set_epoch`操作

Pytorch分布式相关笔记
---

### 关于各个环境相关变量的理解

* `WORLD_SIZE`：总进程的数量，通常一个卡一个进程
* `RANK`：该进程的编号，从0到`WORLD_SIZE-1`
* `MASTER_ADDR`：`RANK=0`进程的IP
* `MASTER_PORT`：`RANK=0`进程的端口号

### 进程间通信相关

* 有关进程通信相关概念参考[Writing Distributed Applications with PyTorch](https://pytorch.org/tutorials/intermediate/dist_tuto.html)

* 其中`all_gather`中需要进行gather操作的Tensor需要具有一致的尺寸，对于不同尺寸的Tensor进行需要进行pad之后再进行gather操作

### 杂七杂八

* Pytorch中的DDP实现了绝大多数模块的同步，BatchNorm需要使用SyncBatchNorm进行转换；早期版本貌似对于2D输入的BatchNorm1d貌似支持较差，最近瞄了一眼最新版本的，貌似改过来了

* 对于buffer，默认从`RANK=0`广播到其他进程。自己实现的带有buffer的模块如果需要做到与单卡训练等价的话，需要通过Pytorch的进程通信机制自行实现多卡对应功能