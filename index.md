---
layout: default
title: Klepsydra Community
---

# Klepsydra Community Edition GitHub Page

## News
* [Klepsydra SDK Workshop](https://klepsydra-technologies.github.io/sections/news/klepsydra_sdk_workshop)
* [Klepsydra Community Edition changes license to Apache 2.0](https://klepsydra-technologies.github.io/sections/news/apache)
* [Klepsydra SDK Community Edition Release 7.0](https://klepsydra-technologies.github.io/sections/news/klepsydra_sdk_community_edition_release_7)

## Overview

This is the GitHub page for Klepsydra Community. The goal of this is page is to provide information for the list of repositories that comprises Klepsydra Community and their documentation.

For further information about Klepsydra Technologies products, please visit our main website [klepsydra.com](https://www.klepsydra.com).

## List of repositories

Klepsydra Community comprises of two main repositories:

*   [Klepsydra Core](https://github.com/klepsydra-technologies/kpsr-core)
*   [Klepsydra Robotics](https://github.com/klepsydra-technologies/kpsr-robotics)

Besides these two, there are another two tutorial repositories:

*   [The Klepsydra Tutorial](https://github.com/klepsydra-technologies/kpsr-tutorial)
*   [High Performance Vision Tutorial](https://github.com/klepsydra-technologies/kpsr-vision-ocv-tutorial)

## Repository inter-dependencies

These repositories are dependent on each other as per the following graph:

![Repositories Deps](/images/repo_dependencies.png)

## Installation

### Klepsydra Core.

The first repository to install is kpsr-core:

```bash
git clone https://github.com/klepsydra-technologies/kpsr-core.git
```

Then follow the installation instruction provided in the [readme file](https://github.com/klepsydra-technologies/kpsr-core/blob/master/README.md).

This repository contains:
*   Core API definition classes
*   Basic in-memory communication API
*   High performance in-memory communication API
*   Code generation tools
*   ROS, DDS, ZMQ and Socket middleware bindings
*   Asynchronous state machine development framework.

Further API and example documentations can be found in this [link](https://github.com/klepsydra-technologies/kpsr-core/tree/master/api-doc).

The API of Klepsydra is split into two:

*   Application API. Which is used by application or functional code that is independent of the underlying middleware or communication frameworks.
*   Composition Code. Which is used to assemble or wire up the application.

This approach of two APIs is reflected in the API docs. It is based in the concepts of:

*   [Strategy Design Pattern](https://en.wikipedia.org/wiki/Strategy_pattern)
*   [Composition Root Design Pattern](https://freecontent.manning.com/dependency-injection-in-net-2nd-edition-understanding-the-composition-root/)
*   [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection)

Some of our code was inspired in the [Spring Framework](https://spring.io/) for Java.

### Klepsydra Robotics.

This repository provides ROS-independent and high-performance enhancements to applications using ROS, MAVROS and specially [OpenCV](https://opencv.org/).

```bash
git clone https://github.com/klepsydra-technologies/kpsr-robotics.git
```

Then follow the installation instruction provided in the [readme file](https://github.com/klepsydra-technologies/kpsr-robotics/blob/master/README.md).

This repository contains:
*   ROS independent Geometry messages
*   ROS independent Lidar messages
*   OpenCV high performance in-memory communications.
*   ROS, DDS and ZMQ middleware bindings

Further API and example documentations can be found in this [link](https://github.com/klepsydra-technologies/kpsr-robotics/tree/master/api-doc).

### Klepsydra ROS 2 executor.

Our own ring buffer lock-free executor for ROS 2 is based on Klepsydra’s main product, the **SDK**. This performance has never been seen in an executor before.

Klepsydra is based in **lock-free programming**. This kind of programming is the high-level wrapper of the atomic operations in the processor, in particular the so-call compare-and-swap or CAS operation. It was invented back in the 70s, but it didn’t really become popular until the early 90s, when it was implemented in higher-level languages and then it really took off when Java included it in the early 2010s.

**Lock-free programming consists of attempting repeatedly to write data in a small piece of memory until the data is in a consistent state**. This is usually depicted as a plane trying to land in a busy airport. If the runway is busy, it flies away and then tries it once and again until success. 

Our first lock free executor implementation for ROS 2 is built on top of the event loop. Every ROS 2 publisher, also called advertiser, is connected to a ring-buffer producer. The timers are connected as well to the schedulers in the event loop. Lastly, the ROS 2 subscribers are connected to the single threaded consumers.

![image](https://user-images.githubusercontent.com/100839634/157836809-7f8c0d0a-f680-4d86-afb7-5bdf424c4872.png)

Our event loop follows a similar design pattern to NodeJS Event Emiter. Although Klepsydra implementation is completely different, the behaviour is the same as all the events happen in one thread. Since the timers and subscriptions are single threaded, there is no need to use any locks.

Find more information about ROS2 in this [link](https://klepsydra-technologies.github.io/ros2).

### Klepsydra Tutorial.

This repository contains a comprehensive tutorial of Klepsydra for ROS and for DDS. It can be used as a template project for new Klepsydra development projects.

```bash
git clone https://github.com/klepsydra-technologies/kpsr-tutorial.git
```

Then follow the installation instruction provided in the [readme file](https://github.com/klepsydra-technologies/kpsr-tutorial/blob/master/README.md).

This repository contains:
*   Code generation examples
*   ROS and DDS binding tutorials.

Step-by-step guides can be found in this [link](https://github.com/klepsydra-technologies/kpsr-tutorial/tree/master/tutorials).

### Klepsydra High Performance Vision Tutorial.

This repository contains a step-by-step guide to build high performance vision applications based on Klepsydra and OpenCV.

```bash
git clone https://github.com/klepsydra-technologies/kpsr-vision-ocv-tutorial.git
```

Then follow the installation instruction provided in the [readme file](https://github.com/klepsydra-technologies/kpsr-vision-ocv-tutorial/blob/master/README.md).

This repository contains:
*   Basic Klepsydra vision services
*   High performance composition examples
*   Unit test examples.

#  License

&copy; Copyright 2019-2020, Klepsydra Technologies, all rights reserved. Licensed under the terms in [LICENSE.md](./LICENSE.md)

This software and documentation are Copyright 2019-2020, Klepsydra Technologies
Limited and its licensees. All rights reserved. See [license file](./LICENSE.md) for full copyright notice and license terms.

#  Contact

https://www.klepsydra.com
support@klepsydra.com
