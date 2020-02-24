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

* conda管理环境相关内容：https://conda.io/docs/user-guide/tasks/manage-environments.html

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

Python Exit Hanlders
---

在程序退出的时候执行

```python
def cleanup():
    print 'Terminating BlobFetcher'
    self._prefetch_process.terminate()
    self._prefetch_process.join()
import atexit
atexit.register(cleanup)
```


Python3 past.builtins模块导入错误
---
```sh
pip install future
conda install future
```

IPython自动重新载入
---

执行
```
%load_ext autoreload
%autoreload 2
```
或者
```
import autoreload
?autoreload
```

KMS Key
---

来自互联网，需要配合[KMS服务器](https://github.com/Wind4/vlmcsd)使用
```
Office Professional Plus 2019：NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP
Office Standard 2019：6NWWJ-YQWMR-QKGCB-6TMB3-9D9HK
Project Professional 2019：B4NPR-3FKK7-T2MBV-FRQ4W-PKD2B
Project Standard 2019：C4F7P-NCP8C-6CQPT-MQHV9-JXD2M
Visio Professional 2019：9BGNQ-K37YR-RQHF2-38RQ3-7VCBB
Visio Standard 2019：7TQNQ-K3YQQ-3PFH7-CCPPM-X4VQ2
Access 2019：9N9PT-27V4Y-VJ2PD-YXFMF-YTFQT
Excel 2019：TMJWT-YYNMB-3BKTF-644 FC-RVXBD
Outlook 2019：7HD7K-N4PVK-BHBCQ-YWQRW-XW4VK
PowerPoint 2019：RRNCX-C64HY-W2MM7-MCH9G-TJHMQ
Publisher 2019：G2KWX-3NW6P-PY93R-JXK2T-C9Y9V
Skype for Business 2019：NCJ33-JHBBY-HTK98-MYCV8-HMKHJ
Word 2019：PBX3G-NWMT6-Q7XBW-PYJGG-WXD33

Windows Server 2016 Datacenter: CB7KF-BWN84-R7R2Y-793K2-8XDDG
Windows Server 2016 Standard: WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY
Windows Server 2016 Essentials: JCKRF-N37P4-C2D82-9YXRT-4M63B

Windows 10 Professional: W269N-WFGWX-YVC9B-4J6C9-T83GX
Windows 10 Enterprise: NPPR9-FWDCX-D2C8J-H872K-2YT43
Windows 10 Education: NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
```

常用KMS指令
---

Windows

```sh
slmgr /skms <host>
slmgr /ipk <keys>
slmgr /ato
```

Office

```sh
# open Office directory
cscript ospp.vbs /sethst:<host>
cscript ospp.vbs /inpkey:<key>
cscript ospp.vbs /act
```

相关参考：

* https://docs.microsoft.com/en-us/deployoffice/vlactivation/tools-to-manage-volume-activation-of-office

* https://docs.microsoft.com/en-us/windows-server/get-started/activation-slmgr-vbs-options

在Lubuntu中使用xrdp
---

* `sudo apt-get install xrdp`
* 修改 `/etc/xrdp/startwm.sh`最后一行为 `. /etc/X11/Xsession`
* 创建或者修改`~/.xsession`的内容为`lxsession -e LXDE -s Lubuntu`

设置终端使用科学上网
---

```sh
export all_proxy=socks5://127.0.0.1:1086
```

使用终端将文件移入回收站
---

```sh
brew install trash
# or
sudo apt install trash

trash <file> <...>
```

做研究与写论文
---

[做研究与写论文-周志华](./how_to_do_research.pdf)

科技写作中的时态
---

[Tense considerations for science writing](./tenses_in_sci_writing.pdf)