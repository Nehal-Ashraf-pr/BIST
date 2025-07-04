# 🧪 Built-In Self-Test (BIST) for 8-bit ALU with 74-bit MISR

This Verilog-based project demonstrates a **Built-In Self-Test (BIST)** system applied to an **8-bit ALU** with a 16-bit multiplier. The design performs autonomous testing using LFSR-based test vectors and MISR-based signature analysis. It’s a complete DFT (Design for Testability) case study.

---

## 📁 Project Structure

| File Name           | Description |
|---------------------|-------------|
| `LFSR_input.v`       | 8-bit LFSR module for pseudo-random test generation |
| `CUT_ALU.v`          | Circuit Under Test: 8-bit ALU with a 16-bit multiplier |
| `MISR_golden_sign.v` | 74-bit MISR to compress ALU output signatures |
| `BIST_tb.v`          | Testbench: Connects LFSR → ALU → MISR and verifies output |

---

## 🔧 ALU Operations

| Signal          | Width  | Description               |
|------------------|--------|---------------------------|
| `sum`,`carry`, `sub`,`borrow`     | 8-bit/1-bit  | Add / Subtract            |
| `mul`            | 16-bit | Multiply                  |
| `xor`, `nand`, `xnor` | 8-bit | Bitwise logic |
| `LL`, `LR`       | 8-bit  | Logical left/right shift  |

All outputs are combined and compressed into a **74-bit MISR** output.

---

## 🔁 BIST Dataflow


```

clk─▶│ LFSR │─▶──▶│  ALU  │─▶──▶│ MISR │─▶ signature
└──────┘     └───────┘     └──────┘

````

- **LFSR**: Generates random 8-bit operands `q[7:0]`
- **ALU (CUT)**: Computes operations in parallel
- **MISR**: Collects and compresses all outputs (8- and 16-bit) into a 74-bit signature
- **Testbench**: Compares final signature to a predefined golden value

---

## ✅ Simulation Details

- **Tool Used**: GTKWave for waveform
- **Golden Signature**:
  ```verilog
  parameter GOLDEN = 74'h1347fb692ca37a6c70c;


* **Test Sequence**:

  * ALU is tested using LFSR-generated inputs `q`
  * When `q` reaches **153**, the sequence **wraps around** (LFSR cycles)
  * At `2165 ns`, the MISR final value matches the **golden signature**

---

## 🔍 Waveform Snapshot

![image](https://github.com/user-attachments/assets/49e65cbe-1b05-4360-8bf4-f1f1c5819bb8)
![image](https://github.com/user-attachments/assets/cd6011ef-a8f0-43de-b0f8-7114ad2420d8)


> ⏱️ At `2165 ns`, final `q = 153`, and `MISR = 0x1347fb692ca37a6c70c` (success!)

---

## 🧪 How to Run

### 🔧 Compile

```bash
iverilog -o bist_test LFSR_input.v CUT_ALU.v MISR_golden_sign.v BIST_tb.v
```

### ▶️ Simulate

```bash
vvp bist_test
```

### 📊 View Waveform

```bash
gtkwave dump.vcd
```

Make sure `BIST_tb.v` contains:

```verilog
$dumpfile("dump.vcd");
$dumpvars;
```

---

## 📚 Concepts Demonstrated

* Design for Testability (DFT)
* LFSR-based pseudorandom pattern generation
* Signature analysis using MISR
* 8-bit & 16-bit data path compression into fixed-width output
* RTL simulation and waveform debugging

---

## 🚀 Improvements for Future Work

* Configurable ALU opcode and dynamic operand selection
* Integrate UART/LED output on FPGA
* Extend MISR to 128-bit for larger designs
* Add assertion-based checking in testbench

---


