---
title: TL;DR(2)
date: 2019-08-28 23:57:19
tags:
---

还是给自己看的杂七杂八的东西 | Yet another naive wiki for myself 😀

<!-- more -->

Anaconda相关
---

* 安装miniconda：https://docs.conda.io/en/latest/miniconda.html

* conda常用操作（来自`tldr conda`）

    ```sh
    # 创建新的环境并安装指定软件包
    conda create --name environment_name python=2.7 matplotlib

    # 显示所有的环境
    conda info --envs

    conda list env

    # 激活/注销某个环境
    conda activate|deactivate environment_name

    # 删除一个环境以及所有的相关包
    conda remove --name environment_name --all

    # 检索软件包
    conda search package_name

    # 在现有的环境中安装软件包
    conda install python=3.4 numpy

    # 显示安装的软件包
    conda list

    # 删除缓存
    conda clean --all
    ```

* 更换conda软件源

```sh
# https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/ && \
conda config --set show_channel_urls yes
```
