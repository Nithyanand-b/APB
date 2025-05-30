# APB Protocol - Verilog Implementation

This project implements a basic version of the **AMBA APB (Advanced Peripheral Bus)** protocol in Verilog, along with a testbench to verify read/write operations.
![RTL](https://github.com/Nithyanand-b/fifo/blob/c7effc400dd6e62b09c8cc8cb1335bd9310311d3/Screenshot%202025-05-30%20210853.png)


## Description

The APB module supports:
- FSM with `IDLE`, `SETUP`, and `ACCESS` states
- 32-bit address and data support
- Internal memory (32 locations)
- Basic APB timing (non-pipelined)

