---
title: Gitlab-CI中失败重试的相关配置
date: 2018-10-11 15:27:19
tags:
---

实习的需要对Gitlab-CI的Pipeline里Job的玄学失败（就是再运行一次能成功的那种）给出一个解决方案。通过阅读文档总结了一些微小的经验。

<!-- more -->

看了一下gitlab官网上有关ci的相关文档，然后找到了一些可以用的东西，并且在公司的gitlab上建了几个repo做了一些实验然后将有用的内容总结了一下

allow_failure
---

* 使用`allow_failure: true `来允许JOB失败而不影响CI中的其他的部分
* 被`allow_failure: true`标记的JOB如果fail，那么将在pipeline中以黄色感叹号标识
* **经过实验，如果先前stage中的某些带有`allow_failure`的JOB失败了，那么将不触发后续stage中的`when: on_failure`**


```yaml
job1:
  stage: test
  script:
    - execute_script_that_will_fail
  allow_failure: true
```

when
---

* 可以是`on_success`，`on_failure`，`always`，`manual`中的一个
* 规定什么时候执行JOB的时机（上面几个选项的字面意思）
* 默认的值是`when: on_success`
* 当一个JOB中含有`when: on_failure`，那么这个JOB当且仅当先前阶段（stage）的JOB失败的时候，当前的JOB才执行，该JOB后续stage中含有`when: on_success`不执行（因为前面有JOB失败了）
* 当一个JOB中含有`when: manual`，那么这个JOB将不会执行（等待手动执行），后续stage中的JOB将照常执行

```yaml
cleanup_build_job:
  stage: cleanup_build
  script:
    - cleanup build when failed
  when: on_failure
```

artifacts:when
---

* 用于设置何时上传artifacts，感觉没什么用

retry
---

* 在Gitlab 9.5之后加入
* 设置JOB失败之后重试的次数
* `retry`字段必须大于等于0，小于等于2（也就是总共最多执行3次JOB）

可能没有什么用的技巧和结论
---

* 在CI/CD中的pipelien中的右上角可以好到ci lint，可以用来验证.gitlab-ci.yml是否符合基本法（格式要求）
* gitlab会将名称相似的JOB放到同一个组中(具体操作件[相关参考资料](https://docs.gitlab.com/ee/ci/pipelines.html#grouping-similar-jobs-in-the-pipeline-graph))
* 即使JOB没有任何问题，也会因为某些玄学原因失败，因此认为设置`retry`是非常有必要的