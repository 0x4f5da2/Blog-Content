---
title: 杂七杂八
date: 2018-10-11 15:27:19
tags:
---

实习的留下来地一些笔记总结来的

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
create user 'root'@'%' identified by 'password'
grant all privileges on *.* to 'root'@'%' with grant option;
flush privileges
```

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
