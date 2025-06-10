# APB Protocol - Verilog Implementation

This project implements **AMBA APB (Advanced Peripheral Bus)** protocol in Verilog, along with a testbench to verify read/write operations.

##
![RTL](https://github.com/Nithyanand-b/APB/blob/main/Screenshot%202025-05-31%20011312.png)


## Description

The APB module supports:
- FSM with `IDLE`, `SETUP`, and `ACCESS` states
- 32-bit address and data support
- Internal memory (32 locations)
- Basic APB timing (non-pipelined)

