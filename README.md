# 🧮 Sequential ALU in Verilog

A synthesizable, clocked Arithmetic Logic Unit (ALU) written in **Verilog HDL**.  
This ALU performs a wide range of arithmetic, logical, shift, and comparison operations.  
It is designed with status flags (`Zero`, `Carry`, `Negative`, `Overflow`) and synchronous output behavior, making it suitable for datapaths, testbenches, or SoCs.

---

## 📚 Table of Contents

- [🛠️ Architecture](#️️️️️️️️️️️️️️️️️️️️️architecture)  
- [📁 Project Structure](#project-structure)  
- [🔧 RTL Design](#rtl-design)  
- [🧪 Simulation](#simulation)  
- [⚙️ Synthesis using Yosys](#synthesis-using-yosys)  
- [🖥️ Netlist Visualization](#netlist-visualization)  
- [📐 Area Estimation](#area-estimation)  
- [🧠 Testbench and Verification](#testbench-and-verification)  
- [📎 References](#references)  
- [✍️ Author](#author)

---

## 🛠️ Architecture

The ALU is divided into:

### 1. Combinational Block
- Performs logic and arithmetic on operands `A`, `B`, using a 4-bit `ALU_sel`.

### 2. Sequential Output Block
- Latches outputs (`result` and `flags`) synchronously at the positive edge of the clock.
- Active-high synchronous reset clears outputs.

<img width="500" alt="Architecture Diagram" src="https://github.com/user-attachments/assets/c1db6eea-09e9-4a55-bba5-ef6a2a4d100d" />

**Features:**
- Clock: Positive-edge triggered  
- Reset: Active-high synchronous  
- Outputs: Registered at each `posedge clk` or cleared on `reset`

---

## 📁 Project Structure

.
├── alu.v # Main ALU RTL module
├── alu_tb.sv # SystemVerilog testbench
├── alu.vcd # Waveform file for GTKWave
├── synth.ys # Yosys synthesis script
├── alu_synth.v # Synthesized gate-level netlist
├── alu_netlist.dot # Graphviz DOT format netlist
└── README.md # Project documentation

yaml
Copy
Edit

---

## 🔧 RTL Design

### ✅ Parameterized Width
- Default: `8 bits`
- Scalable using `parameter WIDTH = N`

### ✅ Supported Operations

| ALU_sel | Operation | Description             |
|---------|-----------|-------------------------|
| `0000`  | ADD       | A + B                   |
| `0001`  | SUB       | A − B                   |
| `0010`  | AND       | Bitwise AND             |
| `0011`  | OR        | Bitwise OR              |
| `0100`  | XOR       | Bitwise XOR             |
| `0101`  | SLL       | Logical left shift      |
| `0110`  | SRL       | Logical right shift     |
| `0111`  | SRA       | Arithmetic right shift  |
| `1000`  | SLT       | Set Less Than (signed)  |

### ✅ Status Flags
- **Zero**: Result is zero  
- **Carry**: Carry-out or borrow  
- **Negative**: MSB of result  
- **Overflow**: Signed overflow detection  

<img width="1262" alt="Design Overview" src="https://github.com/user-attachments/assets/6e4a6641-1421-4359-8de1-e65897d01ed9" />

---

## 🧪 Simulation

### Tools
- `Icarus Verilog` for simulation  
- `GTKWave` for waveform viewing  

### Commands
``bash
iverilog -o alu_sim alu.v alu_tb.sv
vvp alu_sim
gtkwave alu.vcd

## Testbench Preview:
<img width="1326" alt="Testbench Output" src="https://github.com/user-attachments/assets/7a1b4433-9187-4293-84dd-8933e19e99ce" />

⚙️ Synthesis using Yosys
Commands:
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

GTKWave Waveform:
<img width="1076" alt="GTKWave" src="https://github.com/user-attachments/assets/f97e0ea6-e20f-4c38-ba72-f5006b2d5e9b" />

🖥️ Netlist Visualization
Steps:
Generate .dot file using Yosys show

Convert to PNG using Graphviz:

bash
Copy
Edit
dot -Tpng alu_netlist.dot -o alu_netlist.png
<img width="798" alt="Netlist Graph" src="https://github.com/user-attachments/assets/aa958023-949e-43a6-898a-d963141b6463" />
📐 Area Estimation
Technology: Sky130 Standard Cell Library

Cells Used: ~258

Total Area: 1669.10 µm²

🧠 Testbench and Verification
Random input generation (planned)

Edge cases covered:

Signed overflow

Carry-out

SLT

Assertions: (future improvement)

📎 References
Yosys HQ

GTKWave

Graphviz

Sky130 PDK

✍️ Author
Tanishka Bhatia
3rd Year ECE | Thapar Institute
Passionate about RTL, Embedded Systems, and VLSI
Exploring processor design & CAD tools
