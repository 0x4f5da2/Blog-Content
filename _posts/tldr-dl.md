---
title: TL;DR for DL
date: 2019-11-26 18:06:14
tags:
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