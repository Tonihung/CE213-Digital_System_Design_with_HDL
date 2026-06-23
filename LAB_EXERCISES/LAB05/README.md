# LAB05 – Simple MIPS Datapath

This laboratory focuses on designing and verifying a simple datapath based on the **MIPS architecture** using **Verilog HDL** and **ModelSim**.

## Datapath Design

The datapath integrates the following components:

- Register File
- Sign Extension Unit
- Arithmetic Logic Unit
- Data Memory
- Multiplexers

It supports the following MIPS instructions:

- `add rd, rs, rt`
- `lw rt, offset(rs)`
- `sw rt, offset(rs)`

### MIPS Datapath Architecture

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/20021792-5242-4837-834e-87bd25f2f465"
    alt="Simple MIPS datapath architecture"
    width="700"
  >
</p>

A Verilog testbench is used to initialize register and memory values, execute the supported instructions, and observe the datapath results through simulation.
