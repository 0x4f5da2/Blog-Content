---
title: Mockito学习笔记
date: 2018-10-11 14:59:19
tags:
---

在之前实习的时候用mockito写过一段时间的单元测试，根据当时的笔记总结了一下。

<!-- more -->

基本操作
---

之前学的时候看[mockito文档](http://static.javadoc.io/org.mockito/mockito-core/2.23.0/org/mockito/Mockito.html)写的一些东西😅

* 使用`Mockito.mock(...)`创建一个对象之后，该队行会记住所有对他的操作，之后，就可以对一些感兴趣操作经进行验证

* `mock(...)`之后的对象拥有与原对象相同的接口，但是并不具有原对象相同的功能，比如对一个`mock(LinkedList.class)`返回一个对象并不能当作LinkedList进行使用，`mock(...)`之后的的对象一直只会返回一个“stubbed value”（除非被重载）

* 进行`verify(...)`的时候，并不一定要按照先前的操作顺序进行，只需要保证在验证的过程中做验证的在先前使用过

* 使用`InOrder`来按照顺序对操作进行验证

* 使用`when(mockedObject.someMethod(...)).thenReturn(...).thenReturn(...)`或者`when(mockedObject.someMethod(...)).thenReturn(..., ..., ...)`来获得一个类似迭代器的方法

* 如果不是用上面所提到的形式分拆为多个，那么将覆盖上一次的设置

* 使用`Mockito.spy(...)`来获取到一个真的能用的能用并且能够stub的对象

* 使用`mock(someobject.someMethod(...)).thenCallRealMethod()`来在对应的时候调用对象的真实的方法

* 使用`@Mock`, `@Spy`, `@InjectMocks`来简化代码

* 使用`verify(mock, timeout(100)).someMethod()`来显示方法的运行时间

* 一个骚操作：`Car boringStubbedCar = when(mock(Car.class).shiftGear()).thenThrow(EngineNotStarted.class).getMock();`

* 可以用于行为驱动开发
    ```java
    given(dog.bark()).willReturn(2);

    // when
    ...

    then(person).should(times(2)).ride(bike);
    ```

测试springboot的一般步骤
---

* 使用`@MockBean`来标记不想要测试的模块并且是用Mockito的API对返回的记过进行设置

* `@RunWith(SpringJUnit4ClassRunner.class)`和`@SpringBootTest`

* 使用`org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup`获取一个`org.springframework.test.web.servlet.MockMvc`来发起请求

* 必要的import
    * `import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*`
    * `import static org.mockito.Mockito.*`
    * `import static org.springframework.test.web.servlet.result.MockMvcResultMatchers`
    * `import static org.springframework.test.web.servlet.result.MockMvcResultHandlers`
    * `import static org.junit.Assert.*`


如何编写期望抛出一个异常的测试
---

* 使用try...fail...catch（fail由junit提供）

* `@Test(expected= IndexOutOfBoundsException.class)`

估计并不是最佳实践的实践
---

当时做的事情是给后端服务些单元测试，服务很套路的分为controller层，service层，dao层还有一些util工具类。

在单元测试中使用@MockBean，可以在不执行对应的Bean中的内容情况下很方便地指定返回值，或者强行抛出异常，起到了相当于是忽略下层内容地效果。

通过对测试进行分层，可以很方便的对各种情况进行完备的测试，同时分层测试也能够更加容易地定位错误。