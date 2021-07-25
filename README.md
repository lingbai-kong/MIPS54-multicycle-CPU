# MIPS54-multicycle-CPU
同济大学CS《计算机组成原理课程设计》暑期作业TongJi University CS computer organization assignment

## 概述

本工程为2020年同济大学计算机系计算机组成原理课程设计作业。本次实验使用Verilog语言实现了54条MIPS指令的多周期CPU的设计、前仿真、后仿真和下板。

## 一般性设计方法说明

#### 1数据通路设计

1)  阅读每条指令，对每条指令所需执行的功能与过程都有充分的了解

2)  确定每条指令在执行过程中所用到的部件

3)  使用表格列出指令所用部件，并在表格中填入每个部件的数据输入来源

4)  根据表格所涉及部件和部件的数据输入来源，画出数据通路

#### 2绘制总的数据通路

#### 3设计控制器

1)  根据每条指令功能，在已形成的数据通路下，确定该条指令执行的指令流程图

2)  根据每条指令的所需控制信号编排指令操作时间表

3)  进行微操作综合

4)  确定状态转换表、状态转移图及输出逻辑

## 后仿真结果

![image](https://github.com/lingbai-kong/MIPS54-multicycle-CPU/blob/master/%E5%90%8E%E4%BB%BF%E7%9C%9F%E6%B3%A2%E5%BD%A2%E5%9B%BE.png)

## 下板结果

![image](https://github.com/lingbai-kong/MIPS54-multicycle-CPU/blob/master/%E4%B8%8B%E6%9D%BF%E7%BB%93%E6%9E%9C%E5%9B%BE.jpg)

## 备注

1. 因为在疫情期间线上教学，后仿真和下板在教学要求之外，所以测试文件是随便写的

2. 经过了后续硬件组课程的历练发现该CPU存在一些问题，例如周期划分不合理
3. 面向数码管编程初体验
