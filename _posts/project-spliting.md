---
title: Spring-Boot项目模块拆分实践
date: 2018-10-11 15:20:19
tags:
---

实习的时候打的杂之一，需要给一个Spring-Boot后端服务拆分模块

<!-- more -->

## 模块拆分的作用与目的

提高内聚，降低耦合，隔离错误。系统出现问题能够通过回想修改了那些模块较为方便地定位到问题的出现的位置，此外，也可以避免开发者误修改无关代码而引入更多的问题。

此外，进行模块地互粉之后，可以使得项目逻辑更加清晰，新人在上手一个项目的时候，模块的划分能够在一定程度上帮助新人更好地理解整个项目。

## 调研与初步实践

经过调研，进行模块拆分的主要方法有两种：横向拆分和纵向拆分。鉴于account-service的代码量相对较小，以上两种方法均不是特别适用。经过观察，account-service中含有较多的与框架相关的configuration类，因此，在模块拆分开始之前，初步决定将设置相关的内容单独抽取出来，作为一个独立的模块。

当实际上手的时候，却发现事情并想的那么简单，按照原先的拆分方法，出现了模块间的循环依赖。查找相关资料得知解决这个问题的一种做法是使用spring-boot-starter-parent作为各个子模块的parent。然而，对于account-service需要通过我们公司自己的service-parent继承得到一些依赖版本以及插件的配置信息。因此，最后模块拆分的结果很不平均，configuration模块只有几个类，全当踩坑为以后可能存在的多模块需求铺平道路。

## 拆分后的pom文件设置

 本次拆分使用继承的形式最后的项目结构如下（无关内容已经省略）
```
account-service
├─account-service-configuration
│  └─pom.xml
├─account-service-web
│  └─pom.xml
└─pom.xml
```

account-service的pom文件内容如下（省略无关内容）
```
<projec>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>account-service</artifactId>
    <version>0.0.2-SNAPSHOT</version>
    <modules>
        <module>account-service-configuration</module>
        <module>account-service-web</module>
    </modules>
    <packaging>pom</packaging>

    <description>Account service for i18n site.</description>

    <parent>
        <groupId>█████████████████</groupId>
        <artifactId>service-parent</artifactId>
        <version>0.2.2</version>
    </parent>

    <properties>
        <!-- 原先的properties -->
    </properties>

    <dependencies>
        <!-- 公共依赖以及可能在项目根目录执行的插件的依赖 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
    </dependencies>

    <build>
        <pluginManagement>
            <!-- 原先的plugin -->
        </pluginManagement>
    </build>
</project>

```

account-service-web的pom内容如下(account-service-configuration同理)
```
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>account-service</artifactId>
        <groupId>█████████████████</groupId>
        <version>0.0.2-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <packaging>jar</packaging>

    <artifactId>account-service-web</artifactId>
    <version>0.0.2-SNAPSHOT</version>


    <dependencies>
        <!-- 模块所需要的依赖 -->
    </dependencies>

    <profiles>
        <!-- 模块相关的profile写在这里 -->
    </profiles>

    <build>
        <plugins>
            <!-- 模块所需要用到的插件放在这里，由于在account-service的pom里的pluginManagemnt中申明了，所以只用写groupId和artifactId就可以了 -->
        </plugins>
    </build>
</project>

```


## 拆分后的代码中的一些改动

在进行模块拆分之后，由于SpringBoot所需要的东西可能分布在各个模块中，需要为SpringBoot应用指定扫描的包。以此次拆分为例，需要将@SpringBootApplication更改为@SpringBootApplication(scanBasePackages = "█████████████████.account")

## 一些注意事项以及技巧


在最开始单独build一个依赖别的子模块（已经单独install）的子模块会出现一些问题 [相关解释](https://stackoverflow.com/questions/808516/maven-and-dependent-modules)。根据自行以debug模式运行mvn的结果来看，是由于找不到父pom。相关log如下

[DEBUG] Failure to find █████████████████:account-service:0.0.2-SNAPSHOT/maven-metadata.xml in http://██████████████████████████████████/repository/maven-public/ was cached in the local repository, resolution will not be reattempted until the update interval of the-new-nexus has elapsed or updates are forced

---

后端模块的父模块为service-parent，在必要的时候可以查看service-parent中的设置来更好地理解整个项目

---

使用IDEA在行号上右键，单击annotate可以查看每一行是哪个人写的，可以用来甩锅