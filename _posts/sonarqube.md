---
title: sonarqube简易教程
date: 2018-10-11 15:48:19
tags:
---

实习的时候打得杂之一，根据之前的笔记总结来的

<!-- more -->

## 名次解释

sonarqube：一款代码质量管理平台，能够对代码质量进行分析

## 在本地的maven配置sonar插件

编辑maven的settings.xml文件，加入如下内容

```xml
<settings>
    <pluginGroups>
        <pluginGroup>org.sonarsource.scanner.maven</pluginGroup>
    </pluginGroups>
    <profiles>
        <profile>
            <id>sonar</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <!-- 服务器地址，根据实际需要跟换，也可在运行参数中设置 -->
                <sonar.host.url>
                  http://localhost:9000
                </sonar.host.url>
                <!-- ldap的账号和密码，也可在运行时参数中设置 -->
                <sonar.login>username</sonar.login>
                <sonar.password>password</soanr.password>
            </properties>
        </profile>
     </profiles>
</settings>
```

## 启动带有sonarqube的服务器端的docker镜像

```sh
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube
```

### 开始分析项目

使用如下命令

```sh
mvn clean verify sonar:sonar
  
# 将 maven sonar:sonar 作为独立的一步，需要注意是：对于多模块的项目，需要先运行 mvm install
mvn clean install
mvn sonar:sonar
 
# 使用指定版本的soanr插件
mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.4.1.1170:sonar

# 将用户名密码作为参数注入
mvn clean verify sonar:sonar -Dsonar.host.url=$_URL -Dsonar.login=$_USERNAME -Dsonar.password=$_PASSWORD
```


