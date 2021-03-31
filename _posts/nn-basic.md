---
title: 神经网络常用运算&优化器
date: 2021-04-01 00:44:38
tags: 
---

最近复习春招，整理了一下之前写的CS231n里的作业的内容方便复习😀

<!-- more -->

## 常用运算及其求导

### softmax

```python
def softmax_loss_vectorized(W, X, y, reg):
    """
    Softmax loss function, vectorized version.

    Inputs and outputs are the same as softmax_loss_naive.
    """
    # Initialize the loss and gradient to zero.
    loss = 0.0
    dW = np.zeros_like(W)
    # *****START OF CORE CODE*****
    num_train = X.shape[0]
    scores = X @ W
    score_exp_sum = np.sum(np.exp(scores), axis=1)
    loss += np.sum(-scores[np.arange(num_train), y] + np.log(score_exp_sum))
    d_scores = np.zeros_like(scores)
    d_scores[np.arange(num_train), y] -= 1
    d_scores += 1 / score_exp_sum[...,None] * np.exp(scores)
    dW = X.T @ d_scores
    loss /= num_train
    dW /= num_train
    loss += reg * np.sum(W * W)
    dW += 2 * reg * W
    # *****END OF CORE CODE*****
    return loss, dW

```

### svm loss
```python
def svm_loss(x, y):
    """
    Computes the loss and gradient using for multiclass SVM classification.

    Inputs:
    - x: Input data, of shape (N, C) where x[i, j] is the score for the jth
      class for the ith input.
    - y: Vector of labels, of shape (N,) where y[i] is the label for x[i] and
      0 <= y[i] < C

    Returns a tuple of:
    - loss: Scalar giving the loss
    - dx: Gradient of the loss with respect to x
    """
    N = x.shape[0]
    correct_class_scores = x[np.arange(N), y]
    margins = np.maximum(0, x - correct_class_scores[:, np.newaxis] + 1.0)
    margins[np.arange(N), y] = 0
    loss = np.sum(margins) / N
    num_pos = np.sum(margins > 0, axis=1)
    dx = np.zeros_like(x)
    dx[margins > 0] = 1
    dx[np.arange(N), y] -= num_pos
    dx /= N
    return loss, dx
```

### fully connected
```python
def affine_forward(x, w, b):
    """
    Computes the forward pass for an affine (fully-connected) layer.

    The input x has shape (N, d_1, ..., d_k) and contains a minibatch of N
    examples, where each example x[i] has shape (d_1, ..., d_k). We will
    reshape each input into a vector of dimension D = d_1 * ... * d_k, and
    then transform it to an output vector of dimension M.

    Inputs:
    - x: A numpy array containing input data, of shape (N, d_1, ..., d_k)
    - w: A numpy array of weights, of shape (D, M)
    - b: A numpy array of biases, of shape (M,)

    Returns a tuple of:
    - out: output, of shape (N, M)
    - cache: (x, w, b)
    """
    out = None
    # *****START OF CORE CODE*****
    x_reshaped = x.reshape(x.shape[0], -1)
    out = x_reshaped @ w + b
    # *****END OF CORE CODE*****
    cache = (x, w, b)
    return out, cache


def affine_backward(dout, cache):
    """
    Computes the backward pass for an affine layer.

    Inputs:
    - dout: Upstream derivative, of shape (N, M)
    - cache: Tuple of:
      - x: Input data, of shape (N, d_1, ... d_k)
      - w: Weights, of shape (D, M)
      - b: Biases, of shape (M,)

    Returns a tuple of:
    - dx: Gradient with respect to x, of shape (N, d1, ..., d_k)
    - dw: Gradient with respect to w, of shape (D, M)
    - db: Gradient with respect to b, of shape (M,)
    """
    x, w, b = cache
    dx, dw, db = None, None, None
    # *****START OF CORE CODE*****
    n, m = dout.shape
    dx = dout @ w.T
    dw = x.reshape(n, -1).T @ dout
    db = np.sum(dout, axis=0)
    dx = dx.reshape(x.shape)
    # *****END OF CORE CODE*****
    return dx, dw, db
```

### batch norm
```python
def batchnorm_forward(x, gamma, beta, bn_param):
    """
    Forward pass for batch normalization.

    During training the sample mean and (uncorrected) sample variance are
    computed from minibatch statistics and used to normalize the incoming data.
    During training we also keep an exponentially decaying running mean of the
    mean and variance of each feature, and these averages are used to normalize
    data at test-time.

    At each timestep we update the running averages for mean and variance using
    an exponential decay based on the momentum parameter:

    running_mean = momentum * running_mean + (1 - momentum) * sample_mean
    running_var = momentum * running_var + (1 - momentum) * sample_var

    Note that the batch normalization paper suggests a different test-time
    behavior: they compute sample mean and variance for each feature using a
    large number of training images rather than using a running average. For
    this implementation we have chosen to use running averages instead since
    they do not require an additional estimation step; the torch7
    implementation of batch normalization also uses running averages.

    Input:
    - x: Data of shape (N, D)
    - gamma: Scale parameter of shape (D,)
    - beta: Shift paremeter of shape (D,)
    - bn_param: Dictionary with the following keys:
      - mode: 'train' or 'test'; required
      - eps: Constant for numeric stability
      - momentum: Constant for running mean / variance.
      - running_mean: Array of shape (D,) giving running mean of features
      - running_var Array of shape (D,) giving running variance of features

    Returns a tuple of:
    - out: of shape (N, D)
    - cache: A tuple of values needed in the backward pass
    """
    mode = bn_param["mode"]
    eps = bn_param.get("eps", 1e-5)
    momentum = bn_param.get("momentum", 0.9)

    N, D = x.shape
    running_mean = bn_param.get("running_mean", np.zeros(D, dtype=x.dtype))
    running_var = bn_param.get("running_var", np.zeros(D, dtype=x.dtype))

    out, cache = None, None
    if mode == "train":
        # *****START OF CORE CODE*****
        sample_mean = np.mean(x, axis=0)
        sample_var = np.var(x, axis=0)
        x_hat = (x - sample_mean) / np.sqrt(sample_var + eps)
        out = gamma * x_hat + beta
        cache = (x_hat, x, sample_mean, sample_var, gamma, beta, eps)
        running_mean = momentum * running_mean + (1 - momentum) * sample_mean
        running_var = momentum * running_var + (1 - momentum) * sample_var
        # *****END OF CORE CODE*****
    elif mode == "test":
        # *****START OF CORE CODE*****
        x_hat = (x - running_mean) / np.sqrt(running_var + eps)
        out = gamma * x_hat + beta
        # *****END OF CORE CODE*****
    else:
        raise ValueError('Invalid forward batchnorm mode "%s"' % mode)

    # Store the updated running means back into bn_param
    bn_param["running_mean"] = running_mean
    bn_param["running_var"] = running_var

    return out, cache


def batchnorm_backward(dout, cache):
    """
    Backward pass for batch normalization.

    For this implementation, you should write out a computation graph for
    batch normalization on paper and propagate gradients backward through
    intermediate nodes.

    Inputs:
    - dout: Upstream derivatives, of shape (N, D)
    - cache: Variable of intermediates from batchnorm_forward.

    Returns a tuple of:
    - dx: Gradient with respect to inputs x, of shape (N, D)
    - dgamma: Gradient with respect to scale parameter gamma, of shape (D,)
    - dbeta: Gradient with respect to shift parameter beta, of shape (D,)
    """
    dx, dgamma, dbeta = None, None, None
    # *****START OF CORE CODE*****
    # (https://arxiv.org/abs/1502.03167) 

    x_hat, x, sample_mean, sample_var, gamma, beta, eps = cache
    n = x.shape[0]
    d_x_hat = dout * gamma
    d_x1 = d_x_hat / np.sqrt(sample_var + eps)
    d_sample_mean1 = np.sum(-d_x_hat / np.sqrt(sample_var + eps), axis=0)
    d_sample_var = np.sum((x - sample_mean) * -0.5 * np.power((sample_var + eps), -3/2) * d_x_hat, axis=0)
    d_x2 = 2 * (x - sample_mean) * d_sample_var / n
    d_sample_mean2 = np.sum(-2 * (x - sample_mean) * d_sample_var, axis=0) / n
    d_sample_mean = d_sample_mean1 + d_sample_mean2
    d_x3 = d_sample_mean / n

    dx = d_x1 + d_x2 + d_x3
    dgamma = np.sum(dout * x_hat, axis=0)
    dbeta = np.sum(dout, axis=0)
    # *****END OF CORE CODE*****

    return dx, dgamma, dbeta
```

### dropout

```python
def dropout_forward(x, dropout_param):
    """
    Performs the forward pass for (inverted) dropout.

    Inputs:
    - x: Input data, of any shape
    - dropout_param: A dictionary with the following keys:
      - p: Dropout parameter. We keep each neuron output with probability p.
      - mode: 'test' or 'train'. If the mode is train, then perform dropout;
        if the mode is test, then just return the input.
      - seed: Seed for the random number generator. Passing seed makes this
        function deterministic, which is needed for gradient checking but not
        in real networks.

    Outputs:
    - out: Array of the same shape as x.
    - cache: tuple (dropout_param, mask). In training mode, mask is the dropout
      mask that was used to multiply the input; in test mode, mask is None.

    NOTE: Please implement **inverted** dropout, not the vanilla version of dropout.
    See http://cs231n.github.io/neural-networks-2/#reg for more details.

    NOTE 2: Keep in mind that p is the probability of **keep** a neuron
    output; this might be contrary to some sources, where it is referred to
    as the probability of dropping a neuron output.
    """
    p, mode = dropout_param["p"], dropout_param["mode"]
    if "seed" in dropout_param:
        np.random.seed(dropout_param["seed"])

    mask = None
    out = None

    if mode == "train":
        # *****START OF CORE CODE*****
        mask = np.random.rand(*x.shape) < p
        out = x * mask / p
        # *****END OF CORE CODE*****
    elif mode == "test":
        # *****START OF CORE CODE*****
        out = x
        # *****END OF CORE CODE*****

    cache = (dropout_param, mask)
    out = out.astype(x.dtype, copy=False)

    return out, cache


def dropout_backward(dout, cache):
    """
    Perform the backward pass for (inverted) dropout.

    Inputs:
    - dout: Upstream derivatives, of any shape
    - cache: (dropout_param, mask) from dropout_forward.
    """
    dropout_param, mask = cache
    mode = dropout_param["mode"]

    dx = None
    if mode == "train":
        # *****START OF CORE CODE*****
        dx = dout * mask / dropout_param["p"]
        # *****END OF CORE CODE*****
    elif mode == "test":
        dx = dout
    return dx

```

### conv
```python
def conv_forward_naive(x, w, b, conv_param):
    """
    A naive implementation of the forward pass for a convolutional layer.

    The input consists of N data points, each with C channels, height H and
    width W. We convolve each input with F different filters, where each filter
    spans all C channels and has height HH and width WW.

    Input:
    - x: Input data of shape (N, C, H, W)
    - w: Filter weights of shape (F, C, HH, WW)
    - b: Biases, of shape (F,)
    - conv_param: A dictionary with the following keys:
      - 'stride': The number of pixels between adjacent receptive fields in the
        horizontal and vertical directions.
      - 'pad': The number of pixels that will be used to zero-pad the input. 
        

    During padding, 'pad' zeros should be placed symmetrically (i.e equally on both sides)
    along the height and width axes of the input. Be careful not to modfiy the original
    input x directly.

    Returns a tuple of:
    - out: Output data, of shape (N, F, H', W') where H' and W' are given by
      H' = 1 + (H + 2 * pad - HH) / stride
      W' = 1 + (W + 2 * pad - WW) / stride
    - cache: (x, w, b, conv_param)
    """
    out = None
    # *****START OF CORE CODE*****
    n, c, xh, xw = x.shape
    f, _, hh, ww = w.shape
    p = conv_param["pad"]
    s = conv_param["stride"]
    h_ = int(1 + (xh + 2 * p - hh) / s)
    w_ = int(1 + (xw + 2 * p - ww) / s)
    out = np.zeros((n, f, h_, w_))
    x_paded = np.pad(x, ((0,0),(0,0),(p,p),(p,p)), mode="constant", constant_values=0)
    for i in range(h_):
      for j in range(w_):
        ii = i * s
        jj = j * s
        temp = x_paded[:,None,:,ii:ii+hh,jj:jj+ww] * w
        temp = np.sum(temp, axis=(2,3,4)) + b
        out[:,:,i,j] = temp
    # *****END OF CORE CODE*****
    cache = (x, w, b, conv_param)
    return out, cache

def conv_backward_naive(dout, cache):
    """
    A naive implementation of the backward pass for a convolutional layer.

    Inputs:
    - dout: Upstream derivatives.
    - cache: A tuple of (x, w, b, conv_param) as in conv_forward_naive

    Returns a tuple of:
    - dx: Gradient with respect to x
    - dw: Gradient with respect to w
    - db: Gradient with respect to b
    """
    dx, dw, db = None, None, None
    # *****START OF CORE CODE*****
    x, w, b, conv_param = cache

    n, c, xh, xw = x.shape
    f, _, hh, ww = w.shape
    p = conv_param["pad"]
    s = conv_param["stride"]
    h_ = int(1 + (xh + 2 * p - hh) / s)
    w_ = int(1 + (xw + 2 * p - ww) / s)
    x_paded = np.pad(x, ((0,0),(0,0),(p,p),(p,p)), mode="constant", constant_values=0)

    dx_paded = np.zeros((x.shape[0], x.shape[1], x.shape[2] + 2 * p, x.shape[3] + 2 * p))
    dw = np.zeros_like(w)
    db = np.zeros_like(b)
    for i in range(h_):
      for j in range(w_):
        ii = i * s
        jj = j * s
        d_temp = dout[:,:,i,j]
        db += np.sum(d_temp, axis=0)
        dw += np.sum(x_paded[:,None,:,ii:ii+hh,jj:jj+ww] * d_temp[:,:,None,None,None], axis=0)
        dx_paded[:,:, ii:ii+hh, jj:jj+ww] += np.sum(w * d_temp[:,:,None,None,None], axis=1)
    if p > 0:
      dx = dx_paded[:,:,p:-p,p:-p]
    else:
      dx = dx_paded
    # *****END OF CORE CODE*****
    return dx, dw, db
```

### max pool
```python
def max_pool_forward_naive(x, pool_param):
    """
    A naive implementation of the forward pass for a max-pooling layer.

    Inputs:
    - x: Input data, of shape (N, C, H, W)
    - pool_param: dictionary with the following keys:
      - 'pool_height': The height of each pooling region
      - 'pool_width': The width of each pooling region
      - 'stride': The distance between adjacent pooling regions

    No padding is necessary here. Output size is given by 

    Returns a tuple of:
    - out: Output data, of shape (N, C, H', W') where H' and W' are given by
      H' = 1 + (H - pool_height) / stride
      W' = 1 + (W - pool_width) / stride
    - cache: (x, pool_param)
    """
    out = None
    # *****START OF CORE CODE*****
    ph = pool_param["pool_height"]
    pw = pool_param["pool_width"]
    s = pool_param["stride"]
    n, c, xh, xw = x.shape
    h_ = int(1 + (xh - ph) / s)
    w_ = int(1 + (xw - pw) / s)
    out = np.zeros((n, c, h_, w_))
    for i in range(h_):
      for j in range(w_):
        ii = i * s
        jj = j * s
        out[:, :, i, j] = np.max(x[:, :, ii:ii+ph, jj:jj+pw], axis=(-2, -1))
    # *****END OF CORE CODE*****
    cache = (x, pool_param)
    return out, cache


def max_pool_backward_naive(dout, cache):
    """
    A naive implementation of the backward pass for a max-pooling layer.

    Inputs:
    - dout: Upstream derivatives
    - cache: A tuple of (x, pool_param) as in the forward pass.

    Returns:
    - dx: Gradient with respect to x
    """
    dx = None
    # *****START OF CORE CODE*****
    x, pool_param = cache
    ph = pool_param["pool_height"]
    pw = pool_param["pool_width"]
    s = pool_param["stride"]
    n, c, xh, xw = x.shape
    h_ = int(1 + (xh - ph) / s)
    w_ = int(1 + (xw - pw) / s)
    dx = np.zeros_like(x)
    for i in range(h_):
      for j in range(w_):
        ii = i * s
        jj = j * s
        temp = x[:, :, ii:ii+ph, jj:jj+pw]
        max_val = np.max(temp, axis=(-2,-1))
        d_temp = dx[:, :, ii:ii+ph, jj:jj+pw]
        d_temp[max_val[..., None, None] == temp] = dout[:,:,i,j].reshape(-1)
    # *****END OF CORE CODE*****
    return dx
```

## 常用优化器

### sgd

```python
def sgd(w, dw, config=None):
    """
    Performs vanilla stochastic gradient descent.

    config format:
    - learning_rate: Scalar learning rate.
    """
    if config is None:
        config = {}
    config.setdefault("learning_rate", 1e-2)

    w -= config["learning_rate"] * dw
    return w, config
```

### sgd w/ momentum

```python
def sgd_momentum(w, dw, config=None):
    """
    Performs stochastic gradient descent with momentum.

    config format:
    - learning_rate: Scalar learning rate.
    - momentum: Scalar between 0 and 1 giving the momentum value.
      Setting momentum = 0 reduces to sgd.
    - velocity: A numpy array of the same shape as w and dw used to store a
      moving average of the gradients.
    """
    if config is None:
        config = {}
    config.setdefault("learning_rate", 1e-2)
    config.setdefault("momentum", 0.9)
    v = config.get("velocity", np.zeros_like(w))

    next_w = None
    # *****START OF CORE CODE*****
    v = config["momentum"] * v  - config["learning_rate"] * dw
    next_w = w + v
    # *****END OF CORE CODE*****
    config["velocity"] = v

    return next_w, config
```

### rmsprop

```python
def rmsprop(w, dw, config=None):
    """
    Uses the RMSProp update rule, which uses a moving average of squared
    gradient values to set adaptive per-parameter learning rates.

    config format:
    - learning_rate: Scalar learning rate.
    - decay_rate: Scalar between 0 and 1 giving the decay rate for the squared
      gradient cache.
    - epsilon: Small scalar used for smoothing to avoid dividing by zero.
    - cache: Moving average of second moments of gradients.
    """
    if config is None:
        config = {}
    config.setdefault("learning_rate", 1e-2)
    config.setdefault("decay_rate", 0.99)
    config.setdefault("epsilon", 1e-8)
    config.setdefault("cache", np.zeros_like(w))

    next_w = None
    # *****START OF CORE CODE*****
    cache = config["decay_rate"] * config["cache"] + (1 - config["decay_rate"]) * dw ** 2
    next_w = w - config["learning_rate"] * dw/ (np.sqrt(cache) + config["epsilon"])
    config["cache"] = cache
    # *****END OF CORE CODE*****
    return next_w, config
```

### adam

```python
def adam(w, dw, config=None):
    """
    Uses the Adam update rule, which incorporates moving averages of both the
    gradient and its square and a bias correction term.

    config format:
    - learning_rate: Scalar learning rate.
    - beta1: Decay rate for moving average of first moment of gradient.
    - beta2: Decay rate for moving average of second moment of gradient.
    - epsilon: Small scalar used for smoothing to avoid dividing by zero.
    - m: Moving average of gradient.
    - v: Moving average of squared gradient.
    - t: Iteration number.
    """
    if config is None:
        config = {}
    config.setdefault("learning_rate", 1e-3)
    config.setdefault("beta1", 0.9)
    config.setdefault("beta2", 0.999)
    config.setdefault("epsilon", 1e-8)
    config.setdefault("m", np.zeros_like(w))
    config.setdefault("v", np.zeros_like(w))
    config.setdefault("t", 0)

    next_w = None
    # *****START OF CORE CODE*****
    config["t"] += 1
    m = config["beta1"] * config["m"] + (1 - config["beta1"]) * dw
    mt = m / (1 - config["beta1"] ** config["t"])
    v = config["beta2"] * config["v"] + (1 - config["beta2"]) * (dw ** 2)
    vt = v / (1 - config["beta2"] ** config["t"])
    next_w = w - config["learning_rate"] * mt / (np.sqrt(vt) + config["epsilon"])
    config["m"] = m
    config["v"] = v
    # *****END OF CORE CODE*****
    return next_w, config
```

## 其他

### mAP

$$
    \mathrm{mAP} = \frac{\Sigma_{i=1}^{n} \mathrm{AP}_i}{n}
$$

$$
    \mathrm{AP}_i = \Sigma_j \mathrm{precision}_j (\mathrm{recall}_j - \mathrm{recall}_{j-1})
$$

### IoU

```python
ixmin = max(pred_bbox[0], gt_bbox[0])
iymin = max(pred_bbox[1], gt_bbox[1])
ixmax = min(pred_bbox[2], gt_bbox[2])
iymax = min(pred_bbox[3], gt_bbox[3])
iw = np.maximum(ixmax - ixmin + 1., 0.)
ih = np.maximum(iymax - iymin + 1., 0.)

inters = iw * ih

area_pred = (pred_bbox[2] - pred_bbox[0] + 1.) * (pred_bbox[3] - pred_bbox[1] + 1.)
area_gt = (gt_bbox[2] - gt_bbox[0] + 1.) * (gt_bbox[3] - gt_bbox[1] + 1.)
uni = area_pred + area_gt - inters

iou = inters / uni
```

### nms

```python
def py_cpu_nms(dets, thresh):
    """
    nms
    :param dets: ndarray [x1,y1,x2,y2,score]
    :param thresh: int
    :return: list[index]
    """
    x1 = dets[:, 0]
    y1 = dets[:, 1]
    x2 = dets[:, 2]
    y2 = dets[:, 3]
    order = dets[:, 4].argsort()[::-1]
    area = (x2 - x1 + 1) * (y2 - y1 + 1)
    keep = []
    while order.size > 0:
        i = order[0]
        keep.append(i)
        xx1 = np.maximum(x1[i], x1[order[1:]])
        yy1 = np.maximum(y1[i], y1[order[1:]])
        xx2 = np.minimum(x2[i], x2[order[1:]])
        yy2 = np.minimum(y2[i], y2[order[1:]])
        w = np.maximum(0, xx2 - xx1 + 1)
        h = np.maximum(0, yy2 - yy1 + 1)
        over = (w * h) / (area[i] + area[order[1:]] - w * h)
        index = np.where(over <= thresh)[0]
        order = order[index + 1] # 不包括第0个
    return keep
# ————————————————
# 版权声明：本文为CSDN博主「leo_fighting」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/zhangliaobet/article/details/99699675
```

### 欧式距离
```python
# X, Y: N*D
dists = np.sqrt(-2 * X @ Y.T + np.sum(np.square(X), axis=1) + np.sum(np.square(Y), axis=1)[:,None])
```