# 🔢 Sequential ALU — Verilog Implementation

This project implements a 32-bit **synchronous ALU** (Arithmetic Logic Unit) in Verilog with support for multiple operations and condition flags. It has been simulated using **Icarus Verilog + GTKWave**, and synthesized using **Yosys** with **Sky130 standard cell library**.

---

## 📁 Table of Contents

- [Features](#features)
- [ALU Operations](#alu-operations)
- [Simulation](#simulation)
- [Synthesis using Yosys](#synthesis-using-yosys)
- [Netlist Visualization](#netlist-visualization)
- [Waveform (GTKWave)](#waveform-gtkwave)
- [Area Estimation](#area-estimation)
- [Testbench and Verification](#testbench-and-verification)
- [References](#references)

---

## ✨ Features

- 32-bit synchronous ALU with:
  - Register-controlled inputs and output
  - Function select encoding
  - Flags: Carry, Zero, Negative, Overflow
- Edge case handling for signed/unsigned operations
- RTL and Gate-level simulation
- Synthesis using Sky130 PDK standard cells

---

## 🧮 ALU Operations

| Function Select | Operation     | Description            |
|-----------------|---------------|------------------------|
| 0000            | ADD           | A + B                  |
| 0001            | SUB           | A - B                  |
| 0010            | AND           | A & B                  |
| 0011            | OR            | A \| B                 |
| 0100            | XOR           | A ^ B                  |
| 0101            | SLT           | Set if A < B (signed)  |
| 0110            | SHL           | Shift A left by 1      |
| 0111            | SHR           | Shift A right by 1     |

---

## 🧪 Simulation

Run the following to simulate with Icarus Verilog:

```bash
iverilog -g2012 -o alu_tb ALU.v ALU_tb.sv
vvp alu_tb
gtkwave alu.vcd
Ensure your testbench includes:

verilog
Copy
Edit
$dumpfile("alu.vcd");
$dumpvars(0, ALU_tb);
⚙️ Synthesis using Yosys
Commands used for RTL to Gate-level synthesis:

tcl
Copy
Edit
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog alu.v
synth -top ALU
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
stat -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog alu_synth.v
show -format dot -prefix alu_netlist
🖥️ Netlist Visualization
Steps:

Generate .dot using Yosys show command.

Convert to PNG using Graphviz:

bash
Copy
Edit
dot -Tpng alu_netlist.dot -o alu_netlist.png
<img width="798" alt="Netlist Graph" src="https://github.com/user-attachments/assets/aa958023-949e-43a6-898a-d963141b6463" />
📊 Waveform (GTKWave)
Visual output from GTKWave showing result and flags:

<img width="1076" alt="GTKWave" src="https://github.com/user-attachments/assets/f97e0ea6-e20f-4c38-ba72-f5006b2d5e9b" />
📐 Area Estimation
Technology: Sky130 Standard Cell Library

Total Cells: ≈ 258

Estimated Area: 1669.10 µm²

🧠 Testbench and Verification
Inputs tested:

Random combinations of A, B, and function codes

Signed and unsigned boundary cases

Covered cases:

Signed overflow

Carry-out detection

SLT with negative operands

Planned improvements:

Assertion-based verification

Automated input generation

📎 References
Yosys Open Synthesis Suite

GTKWave Viewer

Graphviz Visualizer

Sky130 PDK (SkyWater)

🧑‍💻 Author
Tanishka Bhatia
Electronics and Communication Engineering — TIET
📬 your.email@example.com

markdown
Copy
Edit
