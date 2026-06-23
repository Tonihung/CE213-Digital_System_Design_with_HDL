# LAB07 – Simple Processor

This laboratory focuses on integrating the previously designed datapath, Main Control Unit, and ALU Control Unit to implement a simple MIPS processor using **Verilog HDL** and **ModelSim**.

## Processor Design

The processor integrates the following components:

- Register File
- Sign Extension Unit
- Arithmetic Logic Unit
- Data Memory
- Multiplexers
- Main Control Unit
- ALU Control Unit

The processor supports the following MIPS instructions:

- `add rd, rs, rt`
- `lw rt, offset(rs)`
- `sw rt, offset(rs)`

### Simple MIPS Processor Architecture

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/457791ae-1aed-484b-a6aa-58025f2b79c4"
    alt="Simple MIPS processor architecture"
    width="700"
  >
</p>

A Verilog testbench is used to execute the supported instructions and verify register, memory, datapath, and control-unit operations through simulation.
