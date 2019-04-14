---
title: PyQt笔记
date: 2019-03-19 15:41:19
tags:
---

毕业设计要画一个naive的UI，简单学了一下PyQt，做了一些简单的笔记

<!-- more -->

## 相关文档

PyQt官方的文档不是特别的全面，有的部分甚至还是TODO，然后发现Qt的另外一个Python接口PySide2的API和PyQt基本上是一样的，所以也能PySide2的文档也能看。 ~~为什么我当初要用PyQt~~

* [PyQt5 Documentation](https://www.riverbankcomputing.com/static/Docs/PyQt5/)

* [PySide2 Documentation](https://doc.qt.io/qtforpython/index.html)

## 信号槽

要使用信号槽，必须在代码中包含以下语句

```python
QtCore.QMetaObject.connectSlotsByName(<CLASS_NAME>)
```

两种使用信号槽的方式

* 编码

    ```python
    self.chechBox.clicked['bool'].connect(self.label.setVisible)
    ```

* 注解

    ```python
    @PyQt5.QtCore.pyqtSlot(参数)
    def on_发送者对象名称_发射信号名称(self, 参数):
        pass
    ```

## 使用`pyuic5`生成的代码的（可能并不是）最佳实践

```python
import sys
from PyQt5.QtWidgets import QApplication, QMainWindow
# import classes related to GUI
class MyMainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self, parent=None):
        super(MyMainWindow, self).__init__(parent)
        self.setupUi(self)

if __name__ ==  "__main__":
    app = QApplication(sys.argv)
    myWin = MyMainWindow()
    myWin.show()
    sys.exit(app.exec_())
```

## QtGraph示例

用来画图的，功能很强大，可以用在Python交互式页面输入下面的指令即可打开所有示例

```python
import pyqtgraph.examples
pyqtgraph.examples.run()

```

## QThread

```python
class Worker(QThread):
    singnalOut = pyqtSignal(...)

    def __init__(self, parent=None):
    super(Worker, self).__init__(parent)
    # do some stuff

    def run(self):
    # do some stuff && emit signal
```

## QThreadPool和QRunnable的坑

吐槽一句，关于PyQt稍微深入一点的资料是真的少。最开始想使用`QThreadPool`做一些事情，找不到相关资料就凭感觉写了，最后就掉到了这个坑里。

当时直接继承`QRunnable`类，在类里使用`pyqtSignal(...)`创建一个信号，然后在别处连接该信号与槽函数，然而并不能起到预期的效果，当时觉得非常玄学。

最后找的的相关资料还是PySide2的，由于API基本一样，算是解决了这个问题。能够正常运行的写法如下：

```python
class WorkerSignals(QObject):
    ready = pyqtSignal(str)

class InfoWorker(QRunnable):
    def __init__(self, data, signals):
        super().__init__()
        self.__data = data
        self.__signals = signals

    def run(self):
        result = process_data(self.__data)
        self.__signals.ready.emit(result)

# 其他部分略
```

## 其他

* 使用`QApplication.processEvent()`刷新页面，不过并不推荐在执行长时间操作的时候不断调用该函数。