---
layout: news
title: Klepsydra SDK Community Edition Release 7.0
---

# Klepsydra SDK Community Edition Release 7.0

Keeping our commitment with [open source software](https://klepsydra.com/klepsydra-goes-open-source/), our team has released a large number of features from the [SDK Professional Edition (PE)](https://klepsydra.com/klepsydra-sdk-in-action-data-aggregation-demo/) to the [SDK Community Edition (CE)](http://www.klepsydra.org/). These features includes bug fixing and substantial performance improvements, a full list can be found below.
The previous version of Klepsydra SDK CE was 4.1.0, however, with this release we will jump to version 7.0.0 to match the current version of the SDK PE. In essence, both versions are identical from the performance perspective and only differ on the fact that Klepsydra SDK CE support only Linux operating systems, while the the PE version supports also real-time operating systems like [RTEMS5](https://www.rtems.org/) and [FreeRTOS10](https://www.freertos.org/).
 

![Klepsydra Robot](/images/klepsydra_robot.png) 

## KPSR Core SDK version 7 update features

**Klepsydra SDK** now has better support for publish subscribe operations with smart pointers.

Callback functions using smart pointers can now be used directly, thus allowing more efficient use of memory by eliminating unnecessary copies. The EventEmitter class is updated to provide multiple behaviours depending on the desired use cases:

Single Listener Event Emitter is provided for maximum performance for the case when only one subscriber/listener is attached to a publisher.
Multi Listener Event Emitter is provided for use when multiple subscribers need to be attached. However, the subscribers attached are not expected to be modified during runtime.
Safe Event Emitter is provided for the general case — allowing thread safe way of attaching and removing subscribers to process events.
The core module API is updated to use smart pointers better internally. The Container class allows adding new statistics to be recorded after start – thus allowing statistics for services, publishers and subscribers created during runtime to be recorded.
The High Performance module changes the behaviour of the DataMultiplexer. Each subscriber runs in a separate thread and all listeners attached to a subscriber are on the same thread. This allows finer and more predictable control of tasks and ensures the user has more control over the number of threads used by an application. Better smart pointer handling also reduces the number of copies of data and the API is simplified.
 

## Why does Klepsydra offer open-source versions of their products?
 
To promote our products, as open-source software is widely used and discussed in the developer community.
To extend the market for our products by making them available to many more users.
To build a community of developers around our products who can make their contributions and improve its development.
To attract developers to use our technology by giving them a way to become familiar with Klepsydra code.
To create a standard in the industry. 
Is this thing working? 


