---
title: Kubernetes入门
date: 2018-10-11 15:20:19
tags:
---

实习的时候接触到了Kubernetes（其实主要还是怎么用），根据当时的一些笔记，简单总结一下。

<!-- more -->

* kubernetes使得在集群中分发以及调度应用变得自动化，

* 一个kubernetes集群包含下面的两种资源
    * master：协调整个集群
    * nodes：用来跑应用的，每个node含有一个kubelet，用于管理node以及和master进行通信

> Masters manage the cluster and the nodes are used to host the running applications.

```sh
kubectl version  # show kubectl's version
kubectl get nodes  # show nodes

```

---

> A Deployment is responsible for creating and updating instances of your application 

> Applications need to be packaged into one of the supported container formats in order to be deployed on Kubernetes 

* pods运行与集群内部的网络上，与外界隔离。在默认情况下，同一集群的pods相互可见

* 使用`kubectl proxy`建立起一个到集群内部的http代理，通过代理即可访问集群内的服务

---

* pod是表示由一个或者多个应用容器的所组成的应用抽象，这些容器共享
    * 存储
    * 网络，使用同一个集群地址
    * 有关如何运行每一个容器的配置

> A Pod is a Kubernetes abstraction that represents a group of one or more application containers (such as Docker or rkt), and some shared resources for those containers. 

* pod在kubernetes上是一个原子单位，当创建一个deployment时，我们创建一个含有我们所需要的容器的pod，每一个pod与相对应的node相绑定

> A Pod is a group of one or more application containers (such as Docker or rkt) and includes shared storage (volumes), IP address and information about how to run them. 

* pod跑在node上，一个node可以是一个虚拟机，也可以是一个物理的实体机

> Containers should only be scheduled together in a single Pod if they are tightly coupled and need to share resources such as disk. 

```sh
kubectl get ...  # list resources
kubectl get ...  # show detailed information abount a resource
kubectl logs $POD_NAME  # print the logs from a container in a pod
kubectl exec ...  # execute a command in a pod
kubectl describe pods  # view what containers are inside that pod and what images are used
```

---

> A Kubernetes Service is an abstraction layer which defines a logical set of Pods and enables external traffic exposure, load balancing and service discovery for those Pods.

> Although each Pod has a unique IP address, those IPs are not exposed outside the cluster without a Service. Services allow your applications to receive traffic

* service是一种在pod变动的时候使得服务仍然可用的抽象，发现并路由流浪的工作由kubernetes service完成


```sh
kubectl delete service -l run=kubernetes-bootcamp  # 删除service
```

---

* 使用k8s能够很好地横向拓展我们服务，以便承载更加大地流量，k8s也支持自动地拓展pod

> You can create from the start a Deployment with multiple instances using the --replicas parameter for the kubectl run command 

> Scaling is accomplished by changing the number of replicas in a Deployment.

* 当一个应用有了多个运行实例，那么就可以进行不停机地滚动更新

```sh
kubectl scale deployments/kubernetes-bootcamp --replicas=4
# 设置kubernetes-bootcamp的pod数量到16

kubectl describe deployments/kubernetes-bootcamp

```

---

* 使用滚动更新能够用逐渐升级pod的方式使得应用完全不停机

>  Service will load-balance the traffic only to available Pods during the update
> Rolling updates allow the following actions:
>
> * Promote an application from one environment to another (via container image updates)
> * Rollback to previous versions
> * Continuous Integration and Continuous Delivery of applications with zero downtime

```sh
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=gcr.io/google-samples/kubernetes-bootcamp:v10
# 设置新的镜像 滚动更新

kubectl rollout undo deployments/kubernetes-bootcamp
# 滚回原先的版本
```

