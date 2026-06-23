# Digital System Design with HDL

The course focuses on implementing fundamental digital circuits using **Verilog HDL**. The coursework covers combinational circuits, sequential circuits, registers, counters, finite state machines, memory systems, arithmetic logic units, control units, datapaths, and simple processor architectures.

Each design is accompanied by a **testbench** used to simulate its operation, verify its functionality, and evaluate its outputs under different input conditions.

Through laboratory exercises and a final project, students gain practical experience in HDL coding, RTL design, functional simulation, waveform analysis, debugging, and digital system verification.

---

## Course Information

| Item | Details |
|---|---|
| **Course** | Digital System Design with HDL |
| **Course Code** | CE213 |
| **Class Code** | CE213.Q21 |
| **Semester** | Semester II, 2025–2026 |
| **Instructor** | Dr. Tran Thi Diem |

---

## Tools and Technologies

- Verilog HDL
- ModelSim
- RTL Design
- Functional Simulation
- Waveform Analysis
- Digital System Verification

---

## Final Project

### 2D Gaussian Image Filter

The final project implements and verifies a hardware-based **2D Gaussian image filter** supporting both **3 × 3** and **5 × 5** convolution kernels using Verilog HDL and ModelSim.

The design follows a modular RTL architecture consisting of a controller, datapath, line buffers, sliding-window generator, convolution module, and memory components.

A Verilog testbench is used to read input image data from HEX files, simulate the filtering process, verify the hardware output, and export the processed image data for further evaluation.

The quality of the filtered output is evaluated using metrics such as **Mean Squared Error (MSE)** and **Peak Signal-to-Noise Ratio (PSNR)**. The implementation results are also compared with selected previous FPGA-based Gaussian filtering designs.

---

## Laboratory Exercises

### LAB01 – Introduction to Verilog HDL and ModelSim

Introduction to creating, compiling, simulating, and verifying Verilog HDL designs using ModelSim. This lab is tutorial-based and does not include a separate implementation.

### LAB02 – Synchronous Counter and Register File

Implementation of a synchronous counter with preset and clear functions, together with a **32 × 32-bit register file** using Verilog HDL.

### LAB03 – Finite State Machine and Data Memory

Implementation of a Moore and Mealy finite state machine for detecting the `010` sequence and an SRAM-based data memory module.

### LAB04 – Arithmetic Logic Unit and Multiplexer

Implementation of a **32-bit Arithmetic Logic Unit (ALU)** supporting arithmetic and logical operations, together with parameterized multiplexers.

### LAB05 – Simple MIPS Datapath

Design of a simple MIPS datapath by integrating previously implemented modules to execute the `add`, `lw`, and `sw` instructions.

### LAB06 – Simple MIPS Control Unit

Implementation of the main Control Unit and ALU Control modules responsible for generating control signals for the simple MIPS datapath.

### LAB07 – Simple MIPS Processor

Integration of the datapath, main Control Unit, and ALU Control modules to implement a simple processor supporting the `add`, `lw`, and `sw` instructions.
