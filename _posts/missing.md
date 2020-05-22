---
title: The Missing Semester 笔记
date: 2020-05-19 03:47:00
tags:
---

发现了一个不错的讲CS专业基本素养的课程，简单的过了一下，对自己不熟的部分简单进行了简单的记录😀

<!-- more -->

## 课程链接

主页：https://missing.csail.mit.edu

视频：https://www.youtube.com/playlist?list=PLyzOVJj3bHQuloKGG59rS43e29ro7I57J

## Shell及相关命令

* 如果需要进入一个目录，需要有对应的`x`权限；如果需要读取目录下的文件，需要有对应的`r`权限
* 使用`>>`在一个文件最后附加内容
* 诸如`|`, `<`, `>`一类的操作是由shell完成的，又是会由于shell的权限不够而出错。例如：`sudo echo 3 > brightness`，可以使用`echo 3 | sudo tee brightness`进行解决
* `man`或者`--help`的命令解释：`...`表示零个或多个；`[]`表示可选
* 用`'`分隔的字符串是文字字符串，不会替代变量值，而`"`分隔的字符串将替换变量值
* 函数定义
    ```sh
    mcd () {
        mkdir -p "$1"
        cd "$1"
    }
    ```
* Bash脚本的特殊变量
    ```
    $0 - Name of the script
    $1 to $9 - Arguments to the script. $1 is the first argument and so on.
    $@ - All the arguments
    $# - Number of arguments
    $? - Return code of the previous command
    $$ - Process Identification number for the current script
    !! - Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions, then you can quickly execute it with sudo by doing sudo !!
    $_ - Last argument from the last command. If you are in an interactive shell, you can also quickly get this value by typing Esc followed by .
    ```
* Bash脚本可以写在一行，用`;`分开
* 使用`$(COMMAND)`时，它将执行`CMD`，获取命令的输出并将其替换
* `<(CMD)`将执行`CMD`并将输出放置在临时文件中，并用该文件名替换`<()`。例如，`diff <(ls foo) <(ls bar)`将显示foo和bar中的文件之间的差异
* 可以使用`man test`查看bash实现中的比较
* Bash脚本中`test`、单方括号和双方括号的差别：http://mywiki.wooledge.org/BashFAQ/031
* 使用`?`作为单个字符的占位符
* 花括号用于将bash自动命令拓展扩展，例如`{foo,bar}`或者`{a..h}`。在移动或转换文件时，这非常方便。例如`cp /path/to/project/{foo,bar,baz}.sh /newpath`
* 可以在脚本中使用`env`使得脚本更加通用，例如`#! /usr/bin/env python3`
* 使用`find`实时查找，使用`locate`在数据缓存中查找
* 在zsh中使用ctrl+R来搜索历史命令
* 使用`xargs`从管道中获取运行参数
* `2>`表示stderr
* 使用ctrl+z挂起当前进程；使用`bg`+编号继续在后台执行命令，如：`bg %1`；使用`fg`将后台程序调到前台；使用`jobs`查看后台的进程；
* `tmux`的[相关资料](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)以及常用命令
    ```
    Sessions - a session is an independent workspace with one or more windows
    tmux Starts a new session.
    tmux new -s NAME Starts it with that name.
    tmux ls Lists the current sessions

    Windows - Equivalent to tabs in editors or browsers, they are visually separate parts of the same session
    <C-b> c Creates a new window. To close it you can just terminate the shells doing <C-d>
    <C-b> N Go to the N th window. Note they are numbered
    <C-b> p Goes to the previous window
    <C-b> n Goes to the next window
    <C-b> , Rename the current window
    <C-b> w List current windows

    Panes - Like vim splits, panes let you have multiple shells in the same visual display.
    <C-b> " Split the current pane horizontally
    <C-b> % Split the current pane vertically
    <C-b> <direction> Move to the pane in the specified direction. Direction here means arrow keys.
    <C-b> z Toggle zoom for the current pane
    <C-b> [ Start scrollback. You can then press <space> to start a selection and <enter> to copy that selection.
    <C-b> <space> Cycle through pane arrangements.
    ```
* `rsync`是在`scp`上改进而来的，他能提供更加细粒度的控制
* 可以在`ssh`之上使用端口转发，端口转发分为本地端口转发，即把本地端口的数据发送到远端，如`ssh -L 9999:localhost:8888 foobar@remote_server`；和远端端口转发到本地，如`ssh -R 8888:localhost:9999 foobar@remote_server`
* 配置`~/.ssh/config`使得连接服务器更加方便：
    ```
    Host vm
        User foobar
        HostName 172.16.174.141
        Port 2222
        IdentityFile ~/.ssh/id_ed25519
        LocalForward 9999 localhost:8888
    ```
* 使用`sshfs`挂载远端的目录：`sshfs [user@]hostname:[directory] mountpoint`

## Git

* Pro Git：https://git-scm.com/book/en/v2
* 在Git中，“当前所在的位置”称为“ HEAD”

## Profiling and Debugging

* 使用ipdb对Python程序进行调试：
    ```
    l(ist) - Displays 11 lines around the current line or continue the previous listing.
    s(tep) - Execute the current line, stop at the first possible occasion.
    n(ext) - Continue execution until the next line in the current function is reached or it returns.
    b(reak) - Set a breakpoint (depending on the argument provided).
    p(rint) - Evaluate the expression in the current context and print its value. There’s also pp to display using pprint instead.
    r(eturn) - Continue execution until the current function returns.
    q(uit) - Quit the debugger.
    ```
* 使用`pyflakes`、`mypy`等程序代码进行静态检查
* 使用`time`命令对一个命令的运行时间进行分析
* 使用`cProfile`对Python程序的调用耗时进行分析，例如`python -m cProfile -s tottime grep.py`；使用`line_profiler`对每一行的耗时进行分析，例如`kernprof -l -v test.py`
* 使用`memory-profiler`对内存占用进行分析，例如`python -m memory_profiler example.py`
* 使用`pycallgraph`分析程序的调用情况
* 使用`ncdu`分析磁盘占用
* 使用`hyperfine`进行基准测试


## Misc

* 设置守护进程
    ```
    # /etc/systemd/system/myapp.service
    [Unit]
    Description=My Custom App
    After=network.target

    [Service]
    User=foo
    Group=foo
    WorkingDirectory=/home/foo/projects/mydaemon
    ExecStart=/usr/bin/local/python3.7 app.py
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    ```
* Linux中各个目录的用途，详细参看[FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
    ```
        /bin - Essential command binaries
        /sbin - Essential system binaries, usually to be run by root
        /dev - Device files, special files that often are interfaces to hardware devices
        /etc - Host-specific system-wide configuration files
        /home - Home directories for users in the system
        /lib - Common libraries for system programs
        /opt - Optional application software
        /sys - Contains information and configuration for the system
        /tmp - Temporary files (also /var/tmp). Usually deleted between reboots.
        /usr/ - Read only user data
            /usr/bin - Non-essential command binaries
            /usr/sbin - Non-essential system binaries, usually to be run by root
            /usr/local/bin - Binaries for user compiled programs
        /var - Variable files like logs or caches
    ```
