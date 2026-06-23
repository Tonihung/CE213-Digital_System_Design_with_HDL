# LAB03 – Finite State Machine and Data Memory

This laboratory focuses on designing and verifying finite state machines and data memory using **Verilog HDL** and **ModelSim**.

## Exercise 1 – `010` Sequence Detector

Design and verify both **Moore** and **Mealy** finite state machines for detecting the input sequence `010`.

The output is asserted when three consecutive input bits match the sequence.

### Moore FSM

<!-- Add the Moore FSM state diagram here -->

A Verilog testbench reads input sequences from HEX files and verifies the Moore sequence detector.

### Mealy FSM

<!-- Add the Mealy FSM state diagram here -->

A Verilog testbench reads input sequences from HEX files and verifies the Mealy sequence detector.

## Exercise 2 – Data Memory

Design and verify a **1024 × 32-bit data memory** with:

- A 10-bit address input
- A 32-bit write-data input
- A 32-bit read-data output
- Read and write enable signals
- Synchronous write operation
- Asynchronous read operation

A Verilog testbench is used to verify memory read, write, and overwrite operations.
