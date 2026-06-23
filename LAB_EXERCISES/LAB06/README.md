# LAB06 – Simple MIPS Control Unit

This laboratory focuses on designing and verifying the **Main Control Unit** and **ALU Control Unit** for a simple MIPS datapath using **Verilog HDL** and **ModelSim**.

## Control Unit Design

The Main Control Unit generates the control signals required by the datapath, including:

- `RegDst`
- `RegWrite`
- `ALUSrc`
- `MemWrite`
- `MemRead`
- `MemToReg`
- `ALUOp`

The ALU Control Unit uses `ALUOp` and the instruction function field to generate the corresponding `ALUControl` signal.

The design supports the following MIPS instructions:

- `add rd, rs, rt`
- `lw rt, offset(rs)`
- `sw rt, offset(rs)`

### MIPS Datapath and Control Unit

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/8ca87a80-cbe4-4f50-9cd1-9dbe1eb112e8"
    alt="MIPS datapath with Main Control Unit and ALU Control Unit"
    width="700"
  >
</p>

A Verilog testbench is used to verify the generated control signals for each supported instruction.
