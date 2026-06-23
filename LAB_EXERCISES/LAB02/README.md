# LAB02 – Synchronous Counter and Register File

This laboratory focuses on designing and verifying sequential circuits using **Verilog HDL** and **ModelSim**.

## Exercise 1 – Synchronous Counter

Design and verify a 3-bit synchronous counter that follows the specified state-transition sequence. The counter supports **Preset** and **Clear** inputs for loading an arbitrary initial value.

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/07871cea-cc42-4d0b-923a-3fe740c102d1"
    alt="3-bit synchronous counter state-transition diagram"
    width="700"
  >
</p>

A Verilog testbench is used to load different initial values and verify the counter sequence.

## Exercise 2 – Register File

Design and verify a **32 × 32-bit register file** with:

- Two read addresses
- One write address
- One 32-bit write-data input
- Two 32-bit read-data outputs
- Read and write enable signals

A Verilog testbench is used to verify write, read, and overwrite operations.
