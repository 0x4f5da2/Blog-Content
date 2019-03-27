---
title: PyQt笔记
date: 2019-03-19 15:41:19
tags:
---

毕业设计要画一个naive的UI，简单学了一下PyQt，做了一些简单的笔记

<!-- more -->

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

## 其他

* 使用`QApplication.processEvent()`刷新页面
