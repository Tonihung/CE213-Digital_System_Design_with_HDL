# LAB04 – Arithmetic Logic Unit and Multiplexer

This laboratory focuses on designing and verifying combinational circuits using **Verilog HDL** and **ModelSim**.

## Exercise 1 – Arithmetic Logic Unit

Design and verify a **32-bit Arithmetic Logic Unit (ALU)** that performs arithmetic and logical operations based on the control inputs `M`, `S1`, and `S0`.

The ALU also provides an overflow output for signed addition and subtraction operations.

### ALU Operations

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/c32b0d9d-4f35-44aa-a67e-b098f814c275"
    alt="32-bit ALU operation table"
    width="400"
  >
</p>

A Verilog testbench is used to verify each ALU operation with different input values, including signed overflow cases.

## Exercise 2 – Multiplexer

Design and verify a parameterized **2-to-1 multiplexer** with a default data width of 32 bits.

The output is selected according to the `Sel` input:

- `Sel = 0`: Select input `A`
- `Sel = 1`: Select input `B`

A Verilog testbench is used to verify the multiplexer with different input values and data widths.
