# 16-bit Pipelined Multiplier (Verilog | FPGA)

A fully synchronous 16×16 → 32-bit pipelined multiplier designed in Verilog HDL and verified on FPGA hardware.

This project implements multiplication using a shift-and-add partial product approach with a structured multi-stage adder tree. The final 32-bit result is displayed on seven-segment HEX displays.

---

## 📌 Features

- 16×16 → 32-bit multiplication  
- 16 partial product generation  
- Multi-stage reduction tree (s1 → s4)  
- Fully synchronous RTL design  
- Active-low reset  
- Pipeline latency handled safely  
- Real FPGA hardware validation  
- 32-bit output displayed on 8 HEX displays  

---

## 🏗 Architecture

### Partial Product Generation
Each bit of the multiplier generates a shifted version of the multiplicand.

### Adder Tree Reduction
Stage 1 → 8 additions  
Stage 2 → 4 additions  
Stage 3 → 2 additions  
Stage 4 → Final summation  

### Pipelining
Registers inserted between stages to:
- Improve timing
- Ensure stable output
- Support higher clock frequency

---

## 🖥 FPGA I/O Mapping

| Signal | Description |
|--------|-------------|
| SW[15:0] | Load operand A / B |
| KEY[0] | Reset (active-low) |
| KEY[1] | Load A |
| KEY[2] | Load B |
| HEX0–HEX7 | 32-bit result display |

---

## 🚀 How to Use

1. Set switches for operand A  
2. Press KEY[1] to load A  
3. Set switches for operand B  
4. Press KEY[2] to load B  
5. Wait for pipeline delay  
6. View 32-bit result on HEX displays  

---

## 📂 Project Structure

README.md # Project documentation
multiplier_logic.v # Core pipelined multiplier RTL
tb_multiplier_logic.v # Testbench for simulation
multiplier_logic_description.txt # Design explanation
multiplier_logic_nativelink_simulation.rpt # Simulation report

## Quartus Project Files

multiplier_logic.qpf # Quartus project file
multiplier_logic.qsf # Quartus settings file
multiplier_logic.qws # Quartus workspace file

## Backup Files

multiplier_logic.v.bak
tb_multiplier_logic.v.bak

---

## 🛠 Tools Used

- Verilog HDL  
- Intel Quartus Prime  
- FPGA Development Board  


## 🔮 Future Improvements

- Wallace Tree multiplier  
- Booth multiplier  
- Area & timing optimization  
- Performance comparison  

---

## 🎥 Project Demo

Watch the FPGA hardware demonstration here:

▶️ [Project Demo Video](https://www.linkedin.com/feed/update/urn:li:activity:7427333074176204801/?originTrackingId=%2Be%2BRrgwmSLlTld4TnPWYMQ%3D%3D)

---

## 🔗 Connect With Me

💼 LinkedIn Profile:  
👉 www.linkedin.com/in/harshit-settipalli-073356267

---


⭐ If you found this project useful, consider starring the repository.
