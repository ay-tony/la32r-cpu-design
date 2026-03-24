
# 基于 LoongArch-32R 的五级流水线处理器设计

<p align="center">
  <img src="https://img.shields.io/badge/Architecture-LoongArch--32R-blue" alt="Architecture">
  <img src="https://img.shields.io/badge/Verilog-SystemVerilog-green" alt="Verilog">
  <img src="https://img.shields.io/badge/FPGA-Artix--7-orange" alt="FPGA">
  <img src="https://img.shields.io/badge/Tool-Vivado%202023.2-purple" alt="Tool">
</p>

> **声明**：本文档由 Kimi AI 根据项目资料自动生成，仅供参考。

## 📖 项目简介

本项目是基于 **LoongArch-32R (LA32R)** 指令集的国产自主可控处理器设计，实现了一款五级流水线单发射 CPU 核心。LoongArch 是龙芯中科推出的具有完全自主知识产权的指令集架构，本项目的实施有助于推动国产处理器生态建设，培养计算机体系结构专业人才。

### 核心特性

- 🚀 **五级流水线架构**：取指(IF)、译码(ID)、执行(EX)、访存(MEM)、写回(WB)
- 📐 **LoongArch-32R 指令集**：支持国产自主可控指令集架构
- ⚡ **流水线冒险处理**：实现数据前递(Forwarding)和流水线停顿(Stall)机制
- 🔀 **分支预测**：静态预测（分支不跳转）策略
- 💾 **SoC 集成**：支持 GPIO、LED、数码管等板载外设
- ✅ **测试验证**：通过龙芯官方 81 个测试点中的 46 个功能测试点

---

## 🏗️ 项目结构

```
research-class/
├── 📁 cpu-design/              # CPU 设计源代码
│   ├── 📁 mycpu/               # mycpu_env 实验环境
│   │   └── mycpu.srcs/sources_1/new/   # 早期实验源码
│   ├── 📁 ResearchClass/       # Vivado 项目文件（主要设计）
│   │   └── ResearchClass.srcs/sources_1/new/
│   │       ├── CpuTop.sv       # CPU 核心顶层模块
│   │       ├── Decoder.sv      # 指令解码器
│   │       ├── Alu.sv          # 算术逻辑单元
│   │       ├── Lsu.sv          # 访存单元
│   │       ├── RegFile.sv      # 寄存器堆
│   │       ├── Bridge.sv       # 总线桥接器
│   │       ├── SocTop.sv       # SoC 顶层模块
│   │       └── ConfReg.v       # 配置寄存器
│   ├── 📁 src/                 # 实验教程源码
│   │   ├── dc_env/             # 数字电路实验环境
│   │   ├── minicpu_env/        # 单周期 CPU 实验
│   │   └── mycpu_env/          # 流水线 CPU 实验
│   └── 📁 Utils/               # 工具脚本
│       └── DecoderGen/         # 解码器生成工具
├── 📁 report/                  # 项目报告与文档
│   ├── main.typ                # Typst 源文件
│   ├── main.pdf                # PDF 报告
│   ├── template.typ            # 报告模板
│   ├── main.bib                # 参考文献
│   └── fig*.png/jpg            # 插图
├── readme.md                   # 原简要说明
└── README.md                   # 本文件
```

---

## 🔧 硬件架构

### 流水线结构

本处理器采用经典的 **五级流水线** 设计：

| 流水级 | 功能描述 | 主要模块 |
|:------:|:---------|:---------|
| **S1 (IF)** | 取指令 | PC 更新、指令 SRAM 接口 |
| **S2 (ID)** | 译码 | 指令解码、分支判断、控制信号生成 |
| **S3 (EX)** | 执行 | ALU 运算、地址计算 |
| **S4 (MEM)** | 访存 | 数据 SRAM 接口、加载数据处理 |
| **S5 (WB)** | 写回 | 寄存器堆写回 |

### 冒险处理机制

- **数据冒险**：通过数据前递(Forwarding)和流水线停顿(Stall)解决
- **控制冒险**：采用 Cancel 机制，分支计算在 S2 级完成
- **结构冒险**：指令/数据存储器分离设计

### SoC 架构

```
┌─────────────────────────────────────────────────────────────┐
│                         SocTop                              │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                      CpuTop                           │  │
│  │  ┌─────────┐  ┌─────────┐  ┌─────┐  ┌─────┐  ┌─────┐  │  │
│  │  │ Stage 1 │→ │ Stage 2 │→ │ S3  │→ │ S4  │→ │ S5  │  │  │
│  │  │  (IF)   │  │  (ID)   │  │(EX) │  │(MEM)│  │(WB) │  │  │
│  │  └─────────┘  └─────────┘  └─────┘  └─────┘  └─────┘  │  │
│  └───────────────────────────────────────────────────────┘  │
│            ↓                              ↓                 │
│       ┌─────────┐                   ┌──────────┐            │
│       │ InstRam │                   │ 1x2 Bridge│            │
│       └─────────┘                   └────┬─────┘            │
│                                          │                  │
│                    ┌─────────────────────┼─────────────┐   │
│                    ↓                     ↓             │   │
│              ┌─────────┐          ┌──────────┐         │   │
│              │ DataRam │          │ ConfReg  │←────────┘   │
│              └─────────┘          └──────────┘             │
│                                      (GPIO/LED/数码管)      │
└─────────────────────────────────────────────────────────────┘
```

---

## 📋 支持指令集

### 算术运算指令

| 指令 | 描述 | 操作 |
|:----:|:-----|:-----|
| `ADD.W` | 字加法 | `rd = rj + rk` |
| `SUB.W` | 字减法 | `rd = rj - rk` |
| `ADDI.W` | 立即数加法 | `rd = rj + si12` |
| `LU12I.W` | 加载高位立即数 | `rd = si20 << 12` |

### 比较指令

| 指令 | 描述 | 操作 |
|:----:|:-----|:-----|
| `SLT` | 小于置位（有符号） | `rd = (signed(rj) < signed(rk)) ? 1 : 0` |
| `SLTU` | 小于置位（无符号） | `rd = (unsigned(rj) < unsigned(rk)) ? 1 : 0` |

### 逻辑运算指令

| 指令 | 描述 | 操作 |
|:----:|:-----|:-----|
| `AND` | 按位与 | `rd = rj & rk` |
| `OR` | 按位或 | `rd = rj \| rk` |
| `NOR` | 按位或非 | `rd = ~(rj \| rk)` |
| `XOR` | 按位异或 | `rd = rj ^ rk` |

### 移位指令

| 指令 | 描述 | 操作 |
|:----:|:-----|:-----|
| `SLLI.W` | 逻辑左移 | `rd = rj << ui5` |
| `SRLI.W` | 逻辑右移 | `rd = rj >> ui5` |
| `SRAI.W` | 算术右移 | `rd = rj >>> ui5` |

### 分支跳转指令

| 指令 | 描述 | 操作 |
|:----:|:-----|:-----|
| `B` | 无条件跳转 | `PC = PC + si26 << 2` |
| `BL` | 跳转并链接 | `r1 = PC + 4; PC = PC + si26 << 2` |
| `BEQ` | 相等跳转 | `if (rj == rd) PC = PC + si16 << 2` |
| `BNE` | 不等跳转 | `if (rj != rd) PC = PC + si16 << 2` |
| `JIRL` | 寄存器跳转 | `rd = PC + 4; PC = rj + si16 << 2` |

### 访存指令

| 指令 | 描述 | 操作 |
|:----:|:-----|:-----|
| `LD.W` | 加载字 | `rd = MEM[rj + si12]` |
| `ST.W` | 存储字 | `MEM[rj + si12] = rd` |

---

## 🛠️ 开发环境

### 硬件平台

- **FPGA 开发板**：龙芯体系结构教学实验箱 (Artix-7 XC7A200T-FBG676)
- **时钟频率**：10 MHz（调试）/ 100 MHz（板载时钟源）

### 软件工具

| 工具 | 版本 | 用途 |
|:-----|:-----|:-----|
| Xilinx Vivado | 2023.2 | FPGA 综合、实现、仿真 |
| loongarch32r-linux-gnusf-gcc | - | 交叉编译工具链 |
| QEMU | loongarch32r | 指令集模拟器 |
| Typst | - | 文档排版 |

---

## 🚀 快速开始

### 1. 克隆仓库

```bash
git clone <repository-url>
cd research-class
```

### 2. 打开 Vivado 项目

```bash
# 进入 Vivado 项目目录
cd cpu-design/ResearchClass

# 打开 Vivado 2023.2
vivado ResearchClass.xpr
```

### 3. 仿真测试

1. 在 Vivado 中打开 `ResearchClass` 项目
2. 设置仿真顶层为 `SocTop`
3. 加载测试程序到 `InstRam`
4. 运行仿真，查看波形和输出日志

### 4. 上板验证

1. 生成比特流文件
2. 连接龙芯教学实验箱
3. 下载比特流到 FPGA
4. 观察 LED/数码管输出

---

## 📊 测试验证

### 功能测试

处理器通过了龙芯官方 LA32R 指令集测试集中的 **46/81** 个测试点：

```
Test begin!
----[  12455 ns] Number 8'd01 Functional Test Point PASS!!!
----[  36915 ns] Number 8'd02 Functional Test Point PASS!!!
...
```

**已支持功能测试点**：
- n1-n20：基础运算指令
- n21-n36：扩展运算指令
- n37-n46：访存与分支指令

### 性能指标

| 指标 | 数值 |
|:-----|:-----|
| 主频 | 10 MHz（调试配置） |
| IPC | ~0.8（含流水线停顿） |
| 指令延迟 | 5 周期（最差情况） |

---

## 📚 项目文档

| 文档 | 路径 | 说明 |
|:-----|:-----|:-----|
| 完整报告 | `report/main.pdf` | 项目结题报告（Typst 生成） |
| 报告源码 | `report/main.typ` | 可编辑的 Typst 源文件 |
| 实验教程 | `cpu-design/src/README.md` | CPU 设计实验指南 |
| 解码器说明 | `cpu-design/Utils/DecoderGen/` | 自动解码器生成工具 |

---

## 🧑‍💻 项目成员

| 角色 | 姓名 | 邮箱 |
|:-----|:-----|:-----|
| 项目成员 | 安阳 | 22377264@buaa.edu.cn |
| 项目成员 | 王琦 | 22376286@buaa.edu.cn |
| 项目成员 | 刘栗江 | 21371345@buaa.edu.cn |
| 指导老师 | 万寒 | wanhan@buaa.edu.cn |
| 指导老师 | 杨建磊 | jianlei@buaa.edu.cn |

---

## 📖 参考资料

- [《LoongArch CPU 设计实验》官方教程](https://bookdown.org/loongson/_book3/)
- [LoongArch 指令集手册](https://loongson.github.io/LoongArch-Documentation/)
- [第七届"龙芯杯"全国大学生计算机系统能力培养大赛](http://www.nscscc.org/)

### 相关开源项目

- [openLA500](https://github.com/nscscc/nscscc-openla500) - 龙芯官方 LA32R 基线处理器
- [流云处理器](https://github.com/liuyun) - LA32R 单发射 7 级流水线 CPU
- [卅处理器](https://github.com/sa) - 基于记分牌算法的乱序执行处理器
- [NOP 处理器](https://github.com/_nop) - 乱序多发射 Tomasulo 处理器

---

## 📝 许可证

本项目为北京航空航天大学科研课堂项目，仅供学习和研究使用。

---

## 🙏 致谢

感谢龙芯中科提供的开放指令集架构和实验平台支持，感谢"龙芯杯"大赛组委会提供的参考资料和技术指导。

---

<p align="center">
  Made with ❤️ at Beihang University
</p>
