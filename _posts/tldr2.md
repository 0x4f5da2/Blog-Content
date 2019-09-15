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

* 文档：https://docs.conda.io

* conda常用操作（参考`tldr conda`以及[conda cheat sheet](https://docs.conda.io/projects/conda/en/latest/_downloads/1f5ecf5a87b1c1a8aaf5a7ab8a7a0ff7/conda-cheatsheet.pdf)）

    ```sh
    # 显示conda相关信息
    conda info


    # 创建新的环境并安装指定软件包
    conda create --name ENV_NAME python=2.7 PKG

    # 显示所有的环境
    conda info --envs
    conda env list

    # 激活/注销某个环境
    conda activate  ENV_NAME
    conda deactivate

    # 删除一个环境以及所有的相关包
    conda remove --name ENV_NAME --all

    # 检索软件包
    conda search PKGNAME=3.1 "PKGNAME[version='>=3.1.0,<3.2'"

    # 在现有的环境中安装软件包
    conda install PKGNAME==3.1.4 "PKGNAME[version='3.1.2|3.1.4']" "PKGNAME>2.5,<3.2"

    # 显示安装的软件包
    conda list

    # 删除缓存
    conda clean --all

    # 添加channels
    conda config --add channels CHANNELNAME

    # 复制环境
    conda create --clone ENV_NAME --name NEW_NAME

    # 导出/导入环境
    conda env export --name ENV_ANME > env.yaml
    conda env create [--file env.yaml]
    conda list --explicit > pkgs.txt
    conda create --name NEW_ENV --file pkgs.txt
    ```

* 更换conda软件源

`.condarc`
```sh
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
channels:
  - defaults
show_channel_urls: true
```


nginx 设置重定向
---

使用`sudo nginx -s reload`重新载入后，出现如下错误，`unknown directive "if($host" in ...`

原因在于nginx对于语法的检测比较严格，`if`以及`(`和变量符号周围都需要有空格


使用dpkg安装deb软件包
---

```sh
dpkg -i PACKAGE_NAME.deb
```

