[![klepsydra logo](/images/klepsydra_logo.jpg)](http://www.klepsydra.org)

# Klepsydra AI integration with MATLAB<sup>®</sup>

## Table of Contents

<!-- TOC -->
* [Klepsydra AI integration with MATLAB<sup>®</sup>](#klepsydra-ai-integration-with-matlab)
  * [Table of Contents](#table-of-contents)
  * [Overview](#overview)
    * [Klepsydra AI](#klepsydra-ai)
    * [MATLAB<sup>®</sup> for Machine Learning](#matlab-for-machine-learning)
    * [Key Benefits of the MATLAB<sup>®</sup> / Klepsydra Integration](#key-benefits-of-the-matlab--klepsydra-integration)
    * [The Integration Approach: ONNX Export](#the-integration-approach-onnx-export)
    * [Tutorial Structure](#tutorial-structure)
    * [Requirements](#requirements)
      * [Reference documents](#reference-documents)
      * [MATLAB<sup>®</sup>](#matlab)
      * [Klepsydra AI](#klepsydra-ai-1)
      * [Google Protobufs](#google-protobufs)
* [Tutorial Instructions](#tutorial-instructions)
  * [Generating the model and exporting to ONNX in MATLAB<sup>®</sup>](#generating-the-model-and-exporting-to-onnx-in-matlab)
    * [Code Explanation](#code-explanation)
      * [1. YOLOv3-Tiny Export](#1-yolov3-tiny-export)
      * [2. MobileNetV2 Export](#2-mobilenetv2-export)
  * [ONNX Modification](#onnx-modification)
    * [Simplification](#simplification)
      * [Simplifying model obtained from MATLAB<sup>®</sup>](#simplifying-model-obtained-from-matlab)
    * [Klepsydra ONNX Requirements](#klepsydra-onnx-requirements)
      * [Static vs dynamic input size](#static-vs-dynamic-input-size)
    * [Klepsydra AI ONNX API](#klepsydra-ai-onnx-api)
    * [Running the algorithm in Klepsydra AI](#running-the-algorithm-in-klepsydra-ai)
  * [Conclusion](#conclusion)
<!-- TOC -->

## Overview

This tutorial demonstrates the integration of Klepsydra AI with MATLAB<sup>®</sup> to bridge the gap between high-level model design and low-level hardware deployment. It focuses on porting models trained with MATLAB<sup>®</sup> to complex, safety-critical applications—such as space-grade processors, automotive ECUs, and real-time operating systems—where standard deployment paths often fail due to architectural constraints, strict power budgets, or rigorous certification requirements.

![Integration Benefits](/images/matlab_overview.png)

### Klepsydra AI

Klepsydra AI is a high-performance deep neural network (DNN) inference engine specifically engineered for edge computing. Inspired by high-frequency trading technologies, it utilizes advanced lock-free programming and a unique 2D-parallelization framework to maximize the efficiency of edge processors, including space-grade, automotive, and industrial hardware.

### MATLAB<sup>®</sup> for Machine Learning

MATLAB<sup>®</sup> provides a comprehensive ecosystem for machine learning and deep learning, enabling engineers to manage the entire lifecycle from raw data to production. It offers interactive apps for automated data labeling and feature engineering, alongside a vast library of pretrained models and specialized toolboxes for domain-specific tasks in signal processing, computer vision, and robotics.

### Key Benefits of the MATLAB<sup>®</sup> / Klepsydra Integration

Integrating Klepsydra AI into your MATLAB<sup>®</sup> workflow offers several strategic advantages:
* Expanded Hardware Targets: Klepsydra enhances the range of edge platforms you can target. It allows models trained in MATLAB<sup>®</sup> to run efficiently on hardware where standard engines might struggle, including ARM (Cortex-A7, A9, A53), RISC-V, and radiation-hardened processors like the Gaisler GR740 and GR765, as well as automotive ECUs. 
* Performance Optimization: Klepsydra AI is specifically engineered to outperform standard industry runtimes on resource-constrained hardware. Independent benchmarks demonstrate that Klepsydra provides significantly lower latency and higher efficiency compared to TensorFlow Lite, ONNX Runtime, and Apache TVM. 
* Safety-Critical Reliability: For engineers using MATLAB<sup>®</sup> for safety-critical applications like space-onboard data processing or automotive embedded computing, Klepsydra provides a deterministic, low-latency framework that is ECSS-qualified for mission-critical missions. 
* Cybersecurity and IP Protection: A critical advantage of Klepsydra AI is its robust defense against digital threats. Unlike standard open-source runtimes, Klepsydra provides advanced security features, including code obfuscation and model tampering protection, to shield your mission-critical assets and intellectual property.

The diagram below shows the deployment flow for a GR740 on RTEMS, showcasing the extended target support with Klepsydra AI integration.

![Deployment GR740](/images/matlab_gr740_rtems_deployment.png)

Further information on the deployment to GR740 processor can be found in the Klepsydra AI for GR740 guide.

### The Integration Approach: ONNX Export

This tutorial focuses on a seamless workflow between the training environment of MATLAB<sup>®</sup> and Klepsydra. The current approach to this integration is the  Open Neural Network Exchange (ONNX)  format. By exporting a model from MATLAB<sup>®</sup> using the `exportONNXNetwork` function, you can bridge the gap between MATLAB<sup>®</sup>’s powerful training environment and Klepsydra’s high-efficiency execution engine.
The diagram below shows the deployment flow for a Raspberry PI4.

![Deployment approach](/images/matlab_rpi4_linux_deployment.png)

### Tutorial Structure

This tutorial consists of three parts:
* MATLAB<sup>®</sup> Part: Explains the detailed process of exporting a trained model to the ONNX format. 
* ONNX Manipulation Part: Details the necessary transformation steps to ensure full compatibility with the Klepsydra AI engine. 
* Klepsydra API Part: Demonstrates how to test the exported model and provides a comprehensive code snippet and explanation of a Klepsydra AI ONNX implementation.

### Requirements

#### Reference documents

This tutorial refers to four documents included in the trial release of  Klepsydra AI :

* The Klepsydra AI Getting Started Guide: A comprehensive manual for initial setup and environment configuration.
* ONNX Converter User Guide: A technical guide detailing the conversion and optimization of ONNX models for the Klepsydra engine.
* Klepsydra AI Support Matrix: A comprehensive document containing the most up-to-date list of supported processors, operating systems, and external toolchains. It also includes a detailed registry of supported layers as defined by the ONNX standard,
* Klepsydra AI for GR740: A step-by-step guide to run AI applications on the GR740 using Klepsydra AI.

To access these documents as well as the trial software, please send an email to [sales@klepsydra.com](mailto:sales@klepsydra.com).

#### MATLAB<sup>®</sup>

To run this tutorial, you must have  MATLAB<sup>®</sup>  installed along with the following toolboxes and support packages:

*  Deep Learning Toolbox : The core framework for designing and implementing deep neural networks.
*  Deep Learning Toolbox Converter for ONNX Model Format : Required to use the `exportONNXNetwork` function.
*  Support Packages for Specific Models :
* *Computer Vision Toolbox Model for YOLO v3 Object Detection* (for the YOLOv3-Tiny model).
* *Deep Learning Toolbox Model for MobileNet-v2 Network* (for the MobileNetV2 model).

>  Note:  You can install these via the MATLAB<sup>®</sup>  Add-On Explorer  by searching for the names listed above.

#### Klepsydra AI

It is also required to have the  Klepsydra AI  software packages for your specific target platform. You can request a trial version by contacting [sales@klepsydra.com](mailto:sales@klepsydra.com).

#### Google Protobufs

Additionally, the Protobufs library version 3.19.0 must be installed on the target computer. Follow the steps below to complete the installation:

Go to some local folder in the target processor (e.g., $HOME/thirdparties):

``` bash
sudo apt install autoconf libtool
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf
git checkout v3.19.0
git submodule update --init --recursive
./autogen.sh && ./configure
make
sudo make install
```

Optional:
``` bash
cd ../
rm -rf protobuf
```

Further information can be found in the getting started guide.

# Tutorial Instructions

![Deployment flow](/images/matlab_gr740_rtems_deployment.png)

## Generating the model and exporting to ONNX in MATLAB<sup>®</sup>

This section provides clear instructions on the prerequisites and a breakdown of the MATLAB<sup>®</sup> code used to export deep learning models to the ONNX format.

### Code Explanation

The provided scripts automate the process of loading a pretrained network and converting it into an  Open Neural Network Exchange (ONNX)  file. This allows models trained in MATLAB<sup>®</sup> to be used in Klepsydra AI and therefore deploy to specialized edge hardware.

#### 1. YOLOv3-Tiny Export

This snippet targets an object detection model optimized for speed such as [YOLOV3](mathworks.com/help/vision/ref/yolov3objectdetector.html?s_tid=srchtitle_support_results_1_yolov3ObjectDetector)

```matlab
net = yolov3ObjectDetector('tiny-yolov3-coco');
exportONNXNetwork(net.Network, 'yolov3tiny.onnx','OpsetVersion',12,'BatchSize',1);
```
*  `yolov3ObjectDetector` : Loads a pretrained "Tiny YOLOv3" model trained on the COCO dataset.
*  `net.Network` : Extracts the underlying `DAGNetwork` or `dlnetwork` object from the detector wrapper.
*  `OpsetVersion`, 12 : Specifies the ONNX operator set version to ensure compatibility with modern runtimes. Klepsydra current support is only for opset up to version 12.
*  `BatchSize`, 1 : Fixes the input size to process one image at a time, which is standard for real-time inference. Klepsydra current support is only for batch size 1.

#### 2. MobileNetV2 Export

This snippet targets a popular lightweight backbone used for image classification.

```matlab
net = ImagePretrainedNetwork('mobilenetv2');
exportONNXNetwork(net, 'mobilenetv2.onnx','OpsetVersion',12,'BatchSize',1);
```

*  `ImagePretrainedNetwork` : A unified function to load the MobileNetV2 architecture.
*  `exportONNXNetwork` : Converts the classification network directly to a `.onnx` file. Since MobileNetV2 is a `dlnetwork` object, we pass `net` directly rather than accessing a `.Network` property.

## ONNX Modification

### Simplification

After the network has been exported to ONNX format, it is strongly recommended to use the ONNX Simplifier Python library (onnxsim) to simplify the ONNX graph, improving compatibility and potentially reduce the size of the network improving performance.
For the two example mobilenet models presented about we show how simplification affects the respective models.

#### Simplifying model obtained from MATLAB<sup>®</sup>

The command to run and the output obtained is presented below for yolov3tiny. As it can be observed, there is a considerable reduction in the number of layers contained by the model, making the parsing and inference process lighter:

```bash
onnxsim onnxsim yolov3t
iny.onnx yolov3tiny_simp.onnx
Simplifying...
Finish! Here is the difference:
┏━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━┓
┃                    ┃ Original Model ┃ Simplified Model ┃
┡━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━┩
│ Add                │ 13             │ 0                │
│ BatchNormalization │ 11             │ 0                │
│ Cast               │ 39             │ 0                │
│ Ceil               │ 39             │ 0                │
│ Concat             │ 14             │ 1                │
│ Constant           │ 163            │ 28               │
│ Conv               │ 13             │ 13               │
│ Div                │ 39             │ 0                │
│ Floor              │ 26             │ 0                │
│ LeakyRelu          │ 11             │ 11               │
│ MaxPool            │ 6              │ 6                │
│ Mul                │ 13             │ 0                │
│ Pad                │ 13             │ 0                │
│ Relu               │ 13             │ 0                │
│ Resize             │ 1              │ 1                │
│ Shape              │ 13             │ 0                │
│ Split              │ 13             │ 0                │
│ Sub                │ 26             │ 0                │
│ Model Size         │ 33.8MiB        │ 33.8MiB          │
└────────────────────┴────────────────┴──────────────────┘
```

### Klepsydra ONNX Requirements

#### Static vs dynamic input size

The models exported from MATLAB<sup>®</sup> used in this tutorial use a fixed input and output shapes. However, ONNX format in general, supports networks with dynamic input size. However, as Klepsydra AI pre-allocates memory while loading the network and before any predictions are performed, it is essential that the expected input size of data is known. Setting the input size while creating the ONNX representation additionally allows redundant layers to be removed. Static input size can be enforced by the simplifier adding the option `overwrite-input-shape`. For example in the previous case:

```bash
onnxsim --overwrite-input-shape="1,3,416,416" yolov3tiny.onnx yolov3tiny_fixed_input.onnx

#### Batch Size

Klepsydra AI does not do batched inference. So the batch size is always set to 1. In the ONNX representation this can simplify the network graph.

#### Data Format : Channel first (NCHW) vs Channel last (NHWC)

ONNX models represent data in the Channel first model. However, Klepsydra AI requires that data is in the Channel Last format (NHWC). As inputs and outputs are expected to be in channel last format, conversion of the DNN to ONNX may introduce Transpose layers in some cases. Klepsydra AI intelligently ignores these layers to avoid unnecessary data manipulation.
The data format is essential to be kept in mind when comparing the prediction obtained from Klepsydra AI to that obtained from other ONNX based inference engines.

#### Post-Processing layers

Although the post-processing steps of object detection networks like YOLO (and its variants) can be represented in ONNX, these layers involve simple operations which end up being represented as complicated graphs in the ONNX format. Exported yolo models from MATLAB<sup>®</sup> do not contain these post-processing steps, however in general, it is best to split the post-processing steps out of the DNN.

## Klepsydra AI ONNX Support

Klepsydra AI can load models in the ONNX format, with support for opset up to version 12.
For the list of supported layers, please contact [sales@klepsydra.com](maito:sales@klepsydra.com) to receive the support matrix of Klepsydra.

### Testing the exported model

The final exported network can then be tested for compatibility with Klepsydra AI by running the kpsr_ai_onnx_compatible_checker_app.
The model obtained from MATLAB<sup>®</sup>:

```declarative
kpsr_ai_onnx_compatible_checker_app -m mobilenetv2_tf_sim.onnx
Input file provided: 	mobilenetv2_tf_sim.onnx

---- Analysis started. ----
Analysis ended.
---- Layer summary ----
LayerFactory: KlepsydraBackend
LayerFactory: QuantizedKpsrBackendFactory
LayerFactory: QuantizedInt8KpsrBackendFactory
LayerFactory: FullBackendFactory
- Add
- Clip
- Conv
- MatMul
- GlobalAveragePool
  LayerFactory: QuantizedXBackendFactory
  These layers are performed regardless of backends:
- Squeeze

And the model obtained from Pytorch:
kpsr_ai_onnx_compatible_checker_app -m mobilenetv2_pytorch_sim.onnx
Input file provided: 	mobilenetv2_pytorch_sim.onnx

---- Analysis started. ----
Analysis ended.
---- Layer summary ----
LayerFactory: KlepsydraBackend
LayerFactory: QuantizedKpsrBackendFactory
LayerFactory: QuantizedInt8KpsrBackendFactory
LayerFactory: FullBackendFactory
- Add
- Clip
- Conv
- Gemm
- GlobalAveragePool
  LayerFactory: QuantizedXBackendFactory
  These layers are performed regardless of backends:
- Flatten
```
### Klepsydra AI ONNX API

The Klepsydra AI API for ONNX files is straightforward: the ONNX model is passed as input to the OnnxDNNImporter API, as demonstrated in the example below.

```cpp
    std::vector<std::shared_ptr<kpsr::ai::Backend>> extensionBackends(0);
    
    std::unique_ptr<kpsr::ai::DeepNeuralNetworkFactory> factory =
    
    kpsr::ai::OnnxDNNImporter::createDNNFactory(extensionBackends,
    onnxFile, configurationFile);
    
    std::shared_ptr<kpsr::ai::DeepNeuralNetwork> kpsrNetwork = factory->getDNN();
    
    auto saveToFileCallback = [&](const unsigned long &id, const std::vector<float> &result) {
        std::cout << "Got result for input with id: " << id << std::endl;
    };
    
    kpsrNetwork->setCallback(saveToFileCallback);
    
    std::vector<float> inputImage(inputShapeSize.size(), 0.0f);
    
    auto id = kpsrNetwork->predict(inputImage);
```

### Running the algorithm in Klepsydra AI

Once the ONNX file has been simplified and validated in the preceding steps, developers can execute it using the **Klepsydra AI** engine.

The trial software package includes pre-configured examples designed to run your newly generated ONNX file immediately. You can initiate the inference engine using the following command:

```bash
./ai-onnx-example -f ../conf/example.json -m YOUR_ONNX_MODEL.onnx
```

For detailed technical instructions, please refer to the **Klepsydra AI Getting Started Guide**.
To request a trial version of the software, please contact our team at **[sales@klepsydra.com](mailto:sales@klepsydra.com)** or complete the online request form at **[klepsydra.com](https://klepsydra.com)**.

## Conclusion

The integration of Klepsydra AI with MATLAB<sup>®</sup> provides a streamlined and user-friendly workflow for bridging the gap between high-level AI development and complex hardware implementation. By following this simple export-and-convert process, developers can unlock massive benefits, including access to a significantly larger range of deployment targets—from automotive ECUs to space-grade RISC-V and LEON processors.

Beyond hardware flexibility, Klepsydra AI delivers substantial performance gains in latency, throughput, and power efficiency, outperforming standard general-purpose runtimes. This solution ensures your safety-critical and high-performance applications are not only portable but also optimized for the most demanding edge environments.

Please request a trial now to get your MATLAB<sup>®</sup> AI application running efficiently in a larger range of computers.