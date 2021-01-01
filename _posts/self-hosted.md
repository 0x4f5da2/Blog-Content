---
title: Web服务搭建笔记
date: 2021-01-01 19:08:13
tags: 
---

只要不科研，干什么事情都有意思（

<!-- more -->

## Confluence

* 使用下述Dockerfile制作定制的Confluence镜像

    ```Dockerfile
    FROM atlassian/confluence-server:7.10.0

    USER root

    COPY "atlassian-agent.jar" /opt/atlassian/confluence/

    RUN echo 'export CATALINA_OPTS="-javaagent:/opt/atlassian/confluence/atlassian-agent.jar ${CATALINA_OPTS}"' >> /opt/atlassian/confluence/bin/setenv.sh
    ```

* 使用`docker-compose up -d`以及下述配置文件启动服务

    ```yml
    version: '1.0'
    services:
    confluence:
        image: confluence:latest
        container_name: confluence
        volumes:
        - /opt/confluence-home:/var/atlassian/application-data/confluence
        networks:
        - confluence-net
        ports:
        - "8090:8090"
        - "8091:8091"

    db:
        image: postgres:13.1
        container_name: postgres
        environment:
        - POSTGRES_PASSWORD=password
        volumes:
        - /opt/confluence-db:/var/lib/postgresql/data
        networks:
        - confluence-net

    networks:
    confluence-net:
    ```

* 配置postgres对应容器内的数据库

* 使用浏览器完成剩余部分的配置

## Prometheus + Grafana

在GPU节点：

* 使用官网下载的deb包完成`datacenter-gpu-manager`的安装

* 从官方github仓库下载预编译的`node_exporter`

* 从NVIDIA/gpu-monitoring-tools仓库clone源码并按照readme编译安装

* 将`node_exporter`以及`dcgm-exporter`拷贝到一固定位置，此次实践过程放在`/usr/local/bin/`

* 配置服务，添加如下内容到`/lib/systemd/system/`

    * `dcgm-exporter.service`

        ```
        [Unit]
        Description=dcgm-exporter service

        [Service]
        User=root
        ExecStart=/usr/local/bin/dcgm-exporter

        TimeoutStopSec=10
        Restart=on-failure
        RestartSec=5

        [Install]
        WantedBy=multi-user.target
        ```
    * `node-exporter.service`

        ```
        [Unit]
        Description=dcgm-exporter service

        [Service]
        User=root
        ExecStart=/usr/local/bin/dcgm-exporter

        TimeoutStopSec=10
        Restart=on-failure
        RestartSec=5

        [Install]
        WantedBy=multi-user.target
        ```

* 启动服务

    ```sh
    systemctl daemon-reload
    systemctl enable dcgm-exporter.service
    systemctl start dcgm-exporter.service
    systemctl enable node-exporter.service
    systemctl start node-exporter.service
    ```

在服务端：

* 使用`apt`完成Prometheus的安装

* 从官网下载deb包完成Grafana的安装

* 编辑`/etc/prometheus/prometheus.yml`，添加被监控的服务器相关信息。其中，`node_exporter`的端口号为9100；`dcgm-exporter`的端口号为9400。

* Grafana的Web服务在3000端口，登陆并进行配置

* 前往 https://grafana.com/grafana/dashboards 寻找合适的daskboard。