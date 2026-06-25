# 2D Gaussian Image Filter

This project implements and verifies a hardware-based **2D Gaussian image filter** using **Verilog HDL** and **ModelSim**.

The RTL design supports both **3 × 3** and **5 × 5** Gaussian kernels for grayscale image filtering.

## RTL Architecture

The design includes the following modules:

* **Control Unit** – Controls the filtering process
* **Datapath** – Connects the processing modules
* **BRAM** – Stores image pixel data
* **Line Buffer** – Buffers image rows
* **Sliding Window** – Generates convolution windows
* **Convolution Module** – Computes filtered pixel values
* **Top Module** – Integrates the complete design
* **Testbench** – Loads input data and writes output results

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
Output HEX File
```

## Verilog Files

| File                   | Description                     |
| ---------------------- | ------------------------------- |
| `top.v`                | Top-level integration           |
| `control_unit.v`       | Controls the filtering sequence |
| `datapath.v`           | Connects the RTL datapath       |
| `bram.v`               | Stores image pixels             |
| `line_buffer.v`        | Buffers image rows              |
| `window.v`             | Generates sliding windows       |
| `convolution_module.v` | Performs Gaussian convolution   |
| `tb.v`                 | Testbench for simulation        |

## Simulation

Open the Verilog files in **ModelSim** and run the testbench.

Before running the simulation, edit the input HEX file path in `tb.v`:

```verilog
$readmemh(
    "C:/Users/Toni Hung/Documents/UIT/HK2_2025-2026/HDL/PROJECT/hex_input/lena1.hex",
    img_data
);
```

Edit the output HEX file paths:

```verilog
fd = $fopen(
    "C:/Users/Toni Hung/Documents/UIT/HK2_2025-2026/HDL/PROJECT/hex_output/lena1_3x3.hex",
    "w"
);
```

```verilog
fd = $fopen(
    "C:/Users/Toni Hung/Documents/UIT/HK2_2025-2026/HDL/PROJECT/hex_output/lena1_5x5.hex",
    "w"
);
```

Replace these paths with the corresponding locations on your computer.

Select the Gaussian kernel using `SEL_IN`:

```verilog
SEL_IN = 0;
```

* `SEL_IN = 0`: 3 × 3 Gaussian kernel
* `SEL_IN = 1`: 5 × 5 Gaussian kernel

After configuring the file paths and kernel size, compile the Verilog files and run the simulation in ModelSim.

## Python Utilities

Image conversion and evaluation scripts are documented separately in [python/README.md](./python/README.md).
