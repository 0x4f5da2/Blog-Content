---
title: Gradle学习笔记
date: 2018-05-02 23:15:47
tags:
---
最近写JavaEE被依赖弄得很烦，看[视频](https://www.imooc.com/learn/833)学习了一下Gradle。

<!-- more -->

## 安装

* 配置环境变量`GRADLE_HOME`
* 将`%GRADLE_HOME%/bin`添加到Path
* gradle根目录下的文件夹
    * `bin`: 可执行文件
    * `init.d`: 初始化脚本
    * `lib`: gradle本身所依赖的jar


## groovy特点

* 兼容Java语法
* 分号可选
* 类和方法默认`public`
* 自动给属性添加`getter`/`setter`
* 属性可以直接使用`.`获取
* 最后一个表达式的值作为返回值
* `==`等同于`equals()`，不会有`NullPointerException`
```groovy
class ClassTest{
    private int a
    private int b
    ClassTest(int a, int b){
        this.a = a
        this.b = b
    }
    int getA(){
        this.a
    }
}

ClassTest t = new ClassTest(1,2)
t.a = 66
println t.a
println t.b

ClassTest n = null
println n == t
```

* `assert`语句
* 类型、括号可选
* 列表、集合

```groovy
//list

def wantedList = ["女朋友","实习","钱"]
wantedList << "很多钱"
assert wantedList.getClass() == ArrayList
assert wantedList.size() == 4
println wantedList

//map

def buildYears = ['ant':2000, 'maven':2004]
buildYears.gradle = 2009
println buildYears.ant
println buildYears['gradle']
println buildYears.getClass()

```

* 闭包

```groovy
def c1 = {
    v ->
        println v
}

def c2 = {
    println "想要女朋友"
}

def func1(Closure closure) {
    closure("废宅")
}

def func2(Closure closure) {
    closure()
}

func1 c1
func2 c2
```


## groovy构建项目


* 一个简单的例子
```groovy
//构建脚本默认都有Project实例
apply plugin:'java'
// apply是方法名，然后后面的是参数

repositories {
    mavenCentral()
}
// repositories是方法名，然后后面的花括号是一个闭包

dependencies {
    compile group: 'org.apache.struts', name: 'struts2-core', version: '2.5.16'
}

```

## JavaWeb目录结构

* src
    * main
        * java
        * resources
        * webapp
    * test
        * java
        * resources 


## 构建概要

* 每个构建至少包含一个项目
* 项目中包含一个或多个任务
* gradle会基于`build.gradle`实例化一个`org.gradle.api.Project`类，并通过`project`变量使其隐式可用
* 通过group、name、version唯一确定一个组件
* apply：应用插件；dependencies：依赖；repositories：仓库；task：声明项目中的任务

### task

* 包含任务动作以及任务依赖
    * dependsOn
    * doFirst、doLast、<<
* 大多数时候不需要自己定义任务


### 使用脚本构建目录结构

```groovy
def createDir = {
    path ->
        File dir = new File(path)
        if(!dir.exists()){
            dir.mkdirs();
        }

}

task makeJavaDir() {
    def paths = ['src/main/java', 'src/main/resources', 'src/test/java', 'src/test/resources']
    doFirst{
        paths.forEach(createDir)
    }
}

task makeWebDir() {
    dependsOn 'makeJavaDir'
    def paths = ['src/main/java']
    doLast{
        paths.forEach(createDir)
    }
}

```

## 构建生命周期

* 初始化
    * 创建Project类并在脚本中隐式可用
* 配置
    * 生成task的依赖关系与执行顺序
* 执行 

## 依赖管理

* 常用仓库
    * mavenCentral
    * jcenter
    * mavenLocal(`<用户名>/.m2`目录下)
* 按`repositories{...}`中的顺序查找jar

### 依赖关系
* runtime`->`compile
* testCompile`->`compile
* testRuntime`->`runtime
* testRuntime`->`testCompile
* 大多数时候使用编译阶段的依赖
* 例如JDBC可以作为运行时依赖
* 两种写法

        compile group: 'org.apache.struts:struts2-core:2.5.16'
        compile group: 'mysql', name: 'mysql-connector-java', version: '5.1.46'

## 暂时用不到并且懒得写的

* 版本冲突
    * 默认使用最高版本的jar包
    *[修改默认解决策略](https://www.imooc.com/video/14793 "懒得写了")
* [多项目](https://www.imooc.com/video/14794)
    * `allprojects{...}`/`subprojects{...}`
* [测试](https://www.imooc.com/video/14796)
* [发布](https://www.imooc.com/video/14797)
