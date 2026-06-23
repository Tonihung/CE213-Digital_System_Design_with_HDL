# LAB03 – Sequence Detector and Data Memory

This laboratory focuses on designing finite state machines and memory modules using **Verilog HDL** and **ModelSim**.

## Exercise 1 – `010` Sequence Detector

Design and verify both **Moore** and **Mealy** finite state machines that detect the input sequence `010`.

The output is asserted when three consecutive input bits match the required sequence.

### Moore FSM

<!-- Add the Moore state diagram here -->

A Verilog testbench reads input sequences from HEX files and verifies the detector output.

### Mealy FSM

<!-- Add the Mealy state diagram here -->

A separate testbench is used to verify the Mealy implementation with different input sequences.

## Exercise 2 – Data Memory

Design and verify a **1024 × 32-bit data memory** with:

- A 10-bit address input
- A 32-bit write-data input
- A 32-bit read-data output
- Read and write enable signals
- Synchronous write operation
- Asynchronous read operation

A Verilog testbench is used to verify memory read, write, and overwrite operations.
