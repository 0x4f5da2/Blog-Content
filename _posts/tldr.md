---
title: 杂七杂八
date: 2018-10-11 15:27:19
tags:
---

一些太短，不适合单独写一篇博客的杂七杂八的很可能并没有什么用的东西🌚

<!-- more -->

Python获取运行参数
---

* 函数原型:  `def getopt(args, shortopts, longopts = [])：`
* 使用短格式分析串"ho:" 。当一个选项只是表示开关状态时，即后面不带附加参数时，在分析串中写入选项字符。**当选项后面是带一个附加参数时，在分析串中写入选项字符同时后面加一个":" 号**
* 使用长格式分析串列表：["help", "output="] 。长格式串也可以有开关状态，即后面不跟"=" 号。如果跟一个等号则表示后面还应有一个参数 。这个长格式表示"help" 是一个开关选项；"output=" 则表示后面应该带一个参数

Spring中的异常处理@ExceptionHandler
---

* 相关注解
    * @ExceptionHandler：统一处理某一类一场
    * @ControllerAdvise：异常的集中处理
    * @ResponseStatus：将某种异常映射成为HTTP状态码

* 个人理解是将繁琐而不优雅的异常处理（try-catch-finally）交给spring框架进行处理，秩序集中编写错误处理的相关代码即可

开发过程中的各种Object
---
* Persistant Object：持久化队形，在O/R映射中的概念
* Domain Object：抽象出来的业务实体，一般与数据表相对应
* Transfer Object：在应用程序不同 tie( 关系 ) 之间传输的对象
* Data Transfer Object：展示层与服务层之间的数据传输对象
* View Object：用于展示层，把某个指定页面（或组件）的所有数据封装起来
* Business Object：将业务逻辑封装成的对象，可以有多个对象组成
* Plain Ordinary Java Object：我的理解就是最基本的额Java Bean
* Data Access Object：负责持久层的操作，为业务层提供数据接口，通常与PO一起使用

IDEA的一些骚操作
---

* 使用`ctrl + shift + <数字键>`来添加书签
* 使用`ctrl + <数字键>`来快速跳转到书签

* 使用`F11`来添加普通的书签
* 使用`shift + F11`来打开书签列表

编写dtd
---

通过写`<!DOCTYPE ci_config [...]>`是的xml有自动补全以及校验的能力（至少在Jetbrains的IDE下面是这样的）

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE ci_config [
        <!ELEMENT ci_config (access_token, stage_str, env, services)>
        <!ELEMENT access_token (#PCDATA)>
        <!ELEMENT stage_str (#PCDATA)>
        <!ELEMENT env (#PCDATA)>
        <!ELEMENT services (service*)>
        <!ELEMENT service (name, id, token)>
        <!ELEMENT id (#PCDATA)>
        <!ELEMENT name (#PCDATA)>
        <!ELEMENT token (#PCDATA)>
        ]>

<ci_config>
    <access_token>$ACCESS_TOKEN</access_token>
    <stage_str>stage</stage_str>
    <env>gamma</env>
    <services>
        <service>
            <name>general-page</name>
            <id>500</id>
            <token>$GENERAL_TOKEN</token>
        </service>
        <service>
            <name>pano-page</name>
            <id>1474</id>
            <token>$PANO_TOKEN</token>
        </service>
    </services>
</ci_config>
```

使用find命令查找文件
---

* `find [in which dir] -name [filename]`


import static
---

* 导入某个类中的静态的方法

* example

    ```java
    import static java.lang.System.out;
    import static java.lang.Integer.*;

    public class TestStaticImport {
        public static void main(String[] args) {
            out.println(MAX_VALUE);
            out.println(toHexString(42));
        }
    }

    ```

使用maven构建项目的时候，显示“源值1.5已过时 将在未来所有发行版中删除”
---

* 很玄学的是maven知道现在，默认的api level还只是1.5

* 需要在maven的settings.xml中或者pom.xml中设置

* 以下为在pom.xml中设置的一个简单的示例

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>

        <groupId>com.qunhe.i18n</groupId>
        <artifactId>test-mockito</artifactId>
        <version>1.0-SNAPSHOT</version>
        <build>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <configuration>
                        <source>7</source>
                        <target>7</target>
                    </configuration>
                </plugin>
            </plugins>
        </build>

        <dependencies>
            <dependency>
                <groupId>org.mockito</groupId>
                <artifactId>mockito-core</artifactId>
                <version>2.21.0</version>
            </dependency>
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>4.12</version>
            </dependency>
        </dependencies>
        <properties/>
    </project>
    ```

使用Optional
---

Optional是为了解决null安全问题的一个API，使用Optional可以使得代码变得很骚。

### 使用Optional的正确姿势

```java
public static String getChampionName(Competition comp) throws IllegalArgumentException {
    if (comp != null) {
        CompResult result = comp.getResult();
        if (result != null) {
            User champion = result.getChampion();
            if (champion != null) {
                return champion.getName();
            }
        }
    }
    throw new IllegalArgumentException("The value of param comp isn't available.");
}
```

可以写成

```java
public static String getChampionName(Competition comp) throws IllegalArgumentException {
    return Optional.ofNullable(comp)
            .map(c->c.getResult())
            .map(r->r.getChampion())
            .map(u->u.getName())
            .orElseThrow(()->new IllegalArgumentException("The value of param comp isn't available."));
}
```

### 使用optional检查合法性

```java
public void setName(String name) throws IllegalArgumentException {
    this.name = Optional.ofNullable(name).filter(User::isNameValid)
                        .orElseThrow(()->new IllegalArgumentException("Invalid username."));
}
```

try with resources
---

```java
        try (ByteArrayOutputStream out = new ByteArrayOutputStream();
             FileInputStream in =  new FileInputStream(file)) {
            byte[] b = new byte[1024];
            while (in.read(b) != -1) {
                out.write(b, 0, b.length);
            }
            return encodedPdf = new String(Base64.getEncoder().encode(out.toByteArray()));
        }
```

安装MySQL
---

### installation

```sh
sudo apt install mysql-server
```

### login privileges

```sh
sudo mysql -u root
```

```sql
drop user 'root'@'localhost';
create user 'root'@'%' identified by 'password';
grant all privileges on *.* to 'root'@'%' with grant option;
flush privileges
```

```sql
use mysql;
update user set host='%' where user = 'root';
flush privileges;
```

将`/etc/mysql/mysql.conf.d/mysqld.cnf`中的`bind-address`更改为`0.0.0.0`

vim设置换行格式
---

之前在linux下运行windows下写的python脚本，因为换行的原因，并没有能够很好的使得`#!/usr/bin/env python3`很好地运行，遇到了报错，简单地谷歌了一下，找到地解决方法

* set ff=unix 然后保存退出

* wq! 回车vi 

用于自动刷新的http响应头
---

* 1000为时间，单位为毫秒

```java
Response.setHeader("Refresh","1000;URL=http://localhost:8080/servlet/example.htm");
```

maven中设置java版本
---

```xml
<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <java.version>1.8</java.version>
</properties>
```

configuration Annotation Proessor not found in classpath
---

引入如下依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-configuration-processor</artifactId>
    <optional>true</optional>
</dependency>
```

爬虫相关
---

phantomJS可以用于执行网页上的JavaScript

有关plugin中的executions相关tag
---

* 每一个execution需要有一个phase标签标明运行的阶段。goal可能会含有一个默认的phase。如果既没有一个默认的，有没有手动指定。那么插件将不会运行

使用gradle打包可执行的jar
---

```groovy
plugins {
    id 'java'
}

group 'com.project'
version '1.0'

sourceCompatibility = 1.8

repositories {
    mavenCentral()
}

dependencies {
    compile "com.auth0:java-jwt:3.3.0"
    compile 'org.yaml:snakeyaml:1.21'
    compile 'com.alibaba:fastjson:1.2.47'
}

// 下面是用来打包jar的部分

jar {
    manifest {
        attributes "Main-Class": "com.project.util.jwt.MainGui"
    }
    from {
        configurations.compile.collect {
            it.isDirectory()?it:zipTree(it)
        }
    }
}

```

单例模式
---

使用DCL

```java
public class Singleton {
    private volatile static Singleton singleton;

    public static Singleton getInst() {
        if (singleton == null) {
            synchronized (Singleton.class) {
                if (singleton == null) {
                    singleton = new Singleton();
                }
            }
        }
        return singleton;
    }
}
```

使用内部类

```java
public class MyObject {
    private static class MyObjectHandler {
        private static MyObject myObject = new MyObject();
    }
    private MyObject() {

    }
    public static MyObject getInst() {
        return MyObjectHandler.myObject;
    }
}
```

使用static代码块（代码略）

序列化相关：将对象序列化之后再进行反序列化

```java
public class MyObject implements Serializable {
    private static final long serialVersionUID = 888L;
    private static class MyObjectHandler {
        private static final MyObject myObject = new MyObject();
    }
    private MyObject() {

    }
    public static MyObject getInst() {
        return MyObjectHandler.myObject;
    }

    protected Object readResolve() throws Exception {
        System.out.println("called");
        return MyObjectHandler.myObject;
    }
}
```

使用枚举类型：在使用枚举类型的时候，构造方法会自动的被调用

使用Python镜像
---

```sh
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple ...
```

安装torch内存爆炸（MemoryError）
---

由于pip的缓存机制尝试将希望安装库的整个文件缓存到内存，而在限制缓存大小的环境中如果安装包较大就会出现MemoryError的这个错误，可以加入如下参数规避。

```sh
pip --no-cache-dir install ...
```


virtualenv的基本操作
---

```sh
virtualenv --no-site-packages -p <PYTHON_EXE> <DEST_DIR>

source <DESTDIR>/bin/active
```

在Ubuntu中调整swap的大小
---

跑论文的实现在Re-ranking的时候应为内存不够爆炸了，调整了一下swapfile的大小

```sh
sudo swapoff /swapfile
sudo rm /swapfile
sudo fallocate -l 8G /swapfile
chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

参考资料：

[How To Add Swap Space on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-18-04)

简单的HTTP服务器
---


Python自带的一个简单的HTTP服务器，可以测试的时候使用，也可以用于在局域网中临时传输文件
```sh
python3 -m http.server <PORT>
```


X11Forwarding
---

可以通过ssh转发远端主机的GUI程序到本地

以macOS使用ssh连接到Ubuntu为例：

* 更改`/etc/ssh/sshd_config`配置如下
    ```
    AllowAgentForwarding yes
    AllowTcpForwarding yes
    X11Forwarding yes
    X11DisplayOffset 10
    X11UseLocalhost no
    ```

* 使用`sudo service sshd restart`重启ssh服务

* 安装xauth

* 在本地安装XQuartz

* 使用`ssh -Y <user>@<host>`连接主机

* 尝试运行`xclock`查看结果

在带宽的消耗方面，感觉比较消耗带宽：开一个窗口稍微拖动一下就需要大约3～5MB/s的带宽，并且不是特别流畅。除了带宽之外，并不是所有的GUI程序都能够运行。

因此：感觉并没有什么用🌚

在Ubuntu中使用ExFAT文件系统
---

不知道为什么，Ubuntu不默认支持ExFAT，需要装一个小东西

```
sudo apt install exfat-utils
```

macOS技巧
---

* 按住option点击左上角绿色按钮使当前窗口铺满工作区

* 长按右上角绿色按钮建立新的工作区并分屏

* 按住option + shift可以进行精细的音量调节

* command + shift + `.`: 显示隐藏文件

* 按住command可以拖动非顶层窗口

* command + tab 然后放掉 tab 按下 1: Exposé

* 长按字母键可以快速输入带有音标(?)的字母

* command + tab 放掉tab 按下option 放掉command: 切换最小化的窗口到顶层

[Mac键盘快捷键](https://support.apple.com/zh-cn/HT201236)

通过socket传送图片
---

使用场景不好描述，略

```python
import cv2
import numpy as np
import base64
import socket
import os


class Sender:

    def __init__(self, filename):
        self.__server_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        try:
            os.remove(filename)
        except Exception:
            pass
        self.__server_socket.bind(filename)
        print("binded")
        self.__server_socket.listen(1)
        self.__socket = self.__server_socket.accept()[0]
        print("established")

    def send(self, pic):
        stat, encoded = cv2.imencode(".jpg", pic)
        if stat:
            to_send = base64.b64encode(encoded.tostring())
            self.__socket.send(to_send)
            self.__socket.send(b'\x00')


class Receiver:

    def __init__(self, filename):
        self.__socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.__socket.connect(filename)
        self.__buff = b''

    def receive(self):
        while True:
            data = self.__socket.recv(10240)
            pos = data.find(b'\x00')
            if pos == -1:
                self.__buff += data
            else:
                self.__buff += data[0:pos]
                to_decode = self.__buff
                self.__buff = data[pos + 1:]
                decoded = base64.b64decode(to_decode)
                nparr = np.frombuffer(decoded, np.uint8)
                frame = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
                return frame
```

```python
# 发送
import cv2
import PictureTransmitter

if __name__ == '__main__':
    cap = cv2.VideoCapture(0)
    sender = PictureTransmitter.Sender("./test.sock")
    while True:
        stat, frame = cap.read()
        if stat:
            sender.send(frame)
```

```python
# 接收
import cv2
import PictureTransmitter

if __name__ == '__main__':
    receiver = PictureTransmitter.Receiver("test.sock")
    while True:
        frame = receiver.receive()
        cv2.imshow("test", frame)
        if cv2.waitKey(1) == ord('q'):
            break
```

其实是有办法使用本机的X Server，简单的尝试了一下，并不能简单的用起来,就写了上面这个

[相关链接](https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110)

CSS选择器
---

每一条css样式声明（定义）由两部分组成，形式如下：

```css
选择器{
    样式;
}
```

标签选择器开头没有任何的符号、类选择器以`.`开头、ID选择器以`#`开头

子选择器：使用`>`表示制定标签元素的第一代子元素

```css
/* example */
.food>li{border: 1px solid red}
```

包含（后代）选择器：使用空格隔开，用于指定指定标签下的后代元素

```css
/* example */
.fitst span{color: red;}
```

通用选择器：使用`*`指定，匹配所有元素

```css
/* example */
* {color: red}
```

伪类选择符：使用冒号分隔，表示标签的某种状态

```css
/* example */
span:hover{color: red}
```

分组选择符：使用`,`将选择器分开，多个标签定义相同的样式

CSS的继承与权值
---

标签的权值为1，类选择符的权值为10，ID选择符的权值最高为100。

```css
/* example */
p{color:red;} /*权值为1*/
p span{color:green;} /*权值为1+1=2*/
.warning{color:white;} /*权值为10*/
p span.warning{color:purple;} /*权值为1+1+10=12*/
#footer .note p{color:yellow;} /*权值为100+10+1=111*/
```

比较特殊的权值：继承也有权值但很低：大概0.1。

如果权值相同则后出现的样式会覆盖先前出现的样式

使用`!important`设置最高权值

```css
/* example */
p{color:red!important;}
```

Ubuntu合盖不休眠
---

将`/etc/systemd/logind.conf`中的`#HandleLidSwitch=suspend`改成`HandleLidSwitch=ginore`

Ubuntu安装最新的显卡驱动
---

跑一个Docker镜像需要用到cuda10，然后Ubuntu上自动安装的显卡驱动版本过低，并没有办法使用

首先需要使用Software & Updates将下卡驱动切换的开源的版本（要是不切的话就玄学失败）

如果单显卡的话就使用`sudo apt autoremove nvidia-driver-<old_version>`卸载旧的版本

然后执行如下语句

```sh
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt install nvidia-driver-415  # 或者更高

```

在Ubuntu上安装QtDesigner
---

```sh
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple
sudo apt install qt5-default qttools5-dev-tools
```

Jsoup使用概要
---

前一段时间帮别人使用Java写了个爬虫，用到了Jsoup

[JSoupExamples](https://jsoup.org/cookbook/extracting-data/selector-syntax)

OkHttp示例
---

[OkHttpExamples](https://square.github.io/okhttp/#examples)

从Git版本库中移除文件
---

在JetBrains家的IDE内置的Git里加了不需要的文件，发现没有并没有地方删除，只能使用命令行

```sh
git rm -r --cache <filename>
```

Python多线程
---

由于历史原因以及GIL的存在，Python的多线程并不能很好的利用现代的多核处理器，在同一时间，Python中只有一个线程处于运行状态。对于CPU密集型的任务，多线程可能反而会降低运算的性能。

解决办法之一是使用多进程(import multiprocessing)，不过，它的引入会增加程序实现时线程间数据通讯和同步的困难。

Swing Look and Feel
---

```java
try {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
} catch (Exception e) {
    e.printStackTrace();
}
```

Ubuntu笔记本电源管理
---

```sh
sudo apt install tlp
sudo tlp start
```

Ubuntu显示安装过的包
---

```sh
apt list --installed
```

反编译APK
---

* apktool

* dex2jar

VMware Fusion Key
---

```
N0hZWTgtWjhXV1ktRjFNQU4tRUNLTlktTFVYWVg=
```

iStat Key
---

```
RW1haWw6IDk4MjA5MjMzMkBxcS5jb20KU046IEdBV0FFLUZDV1EzLVA4TllCLUM3R0Y3LU5FRFJULVE1RFRCLU1GWkc2LTZORVFDLUNSTVVELThNWjJLLTY2U1JCLVNVOEVXLUVETFo5LVRHSDNTLThTR0E=
```

音频文件滤波，感觉挺好玩的
---

```python
import matplotlib.pyplot as plt
import numpy as np
from scipy import signal
from scipy.io import wavfile

if __name__ == '__main__':
    f, data = wavfile.read("foo.wav")
    print(f, data)
    # ffmpeg -i <input_file> -vn -acodec pcm_s16le -ac 1 -ar 44100 -f wav foo.wav
    lowpass_critical_f = 500
    highpass_critical_f = 500

    data = data * 1.0 / np.max(data)
    x = np.arange(0, len(data)) * 1 / f

    plt.plot(x, data)
    plt.show()

    sos = signal.butter(10, lowpass_critical_f, btype="lowpass", fs=f, output="sos")
    lowpass_filtered = signal.sosfilt(sos, data)
    plt.plot(x, lowpass_filtered)
    plt.show()

    sos = signal.butter(10, highpass_critical_f, btype="highpass", fs=f, output="sos")
    highpass_filtered = signal.sosfilt(sos, data)
    plt.plot(x, highpass_filtered)
    plt.show()

    wavfile.write("highpass.wav", f, highpass_filtered)
    wavfile.write("lowpass.wav", f, lowpass_filtered)
```