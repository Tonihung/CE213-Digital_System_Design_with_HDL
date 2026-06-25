# 2D Gaussian Image Filter

This project implements and verifies a hardware-based **2D Gaussian image filter** using **Verilog HDL** and **ModelSim**.

The RTL design supports **3 × 3** and **5 × 5** Gaussian kernels for grayscale image filtering.

## RTL Architecture

The design follows a modular architecture consisting of:

* **Control Unit** – Controls the filtering process and processing states
* **Datapath** – Connects the memory, buffering, window, and convolution modules
* **BRAM** – Stores input and output image pixels
* **Line Buffer** – Stores image rows required for convolution
* **Sliding Window** – Generates the pixel window for each filtering operation
* **Convolution Module** – Computes the Gaussian-filtered pixel value
* **Top Module** – Integrates all RTL components
* **Testbench** – Loads input pixels, runs the simulation, and writes the filtered output

## Processing Flow

```text
Input HEX File
      ↓
Input BRAM
      ↓
Line Buffer
      ↓
Sliding Window
      ↓
Gaussian Convolution
      ↓
Output BRAM
      ↓
Output HEX File
```

## Verilog Files

| File                   | Description                                           |
| ---------------------- | ----------------------------------------------------- |
| `top.v`                | Top-level module integrating the complete design      |
| `control_unit.v`       | Controls the filtering sequence and processing states |
| `datapath.v`           | Connects and manages the RTL data path                |
| `bram.v`               | Stores image pixel data                               |
| `line_buffer.v`        | Buffers image rows for convolution                    |
| `window.v`             | Generates the sliding pixel window                    |
| `convolution_module.v` | Performs Gaussian convolution                         |
| `tb.v`                 | Simulates and verifies the complete design            |

## Directory Structure

```text
PROJECT/
├── input/
├── output/
├── python/
│   └── README.md
├── verilog/
│   ├── bram.v
│   ├── control_unit.v
│   ├── convolution_module.v
│   ├── datapath.v
│   ├── line_buffer.v
│   ├── tb.v
│   ├── top.v
│   └── window.v
└── README.md
```

## Simulation

Open ModelSim in the `verilog` directory and run:

```tcl
vlog *.v
vsim work.tb
add wave sim:/tb/*
run -all
```

The testbench reads grayscale pixel data from an input HEX file, performs Gaussian filtering, and writes the processed pixels to an output HEX file.

## Python Utilities

Image preprocessing, HEX conversion, output reconstruction, and image-quality evaluation are documented separately in [python/README.md](./python/README.md).
