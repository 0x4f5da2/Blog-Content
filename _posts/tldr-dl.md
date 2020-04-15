---
title: TL;DR for DL
date: 2019-11-26 18:06:14
tags:
mathjax: true
---

给自己炼丹时候看的杂七杂八的东西 | My naive wiki for DL 😀

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

取标题的一种方法
---

【研究目的】+【研究背景】：【研究方法】
如：Towards Cost-Efficient Content Placement in Media Cloud: Modeling and Analysis

研究目的：Towards Cost-Efficient Content Placement
研究背景：Media Cloud
研究方法：Modeling and Analysis
