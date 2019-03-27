---
title: PyQt笔记
date: 2019-03-19 15:41:19
tags:
---

## UI和逻辑分离

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

## 信号槽

```python
# 必须包含以下语句
QtCore.QMetaObject.connectSlotsByName(Form)
```

### 编码

```python
self.chechBox.clicked['bool'].connect(self.label.setVisible)
```

### 注解

```python
@PyQt5.QtCore.pyqtSlot(参数)
def on_发送者对象名称_发射信号名称(self, 参数):
    pass
```

## QtGraph示例子

```python
import pyqtgraph.examples
pyqtgraph.examples.run()

```

## 其他

* 使用`QApplication.processEvent()`刷新页面
