`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// Module Name: APB
// Description: APB (Advanced Peripheral Bus) protocol implementation
//////////////////////////////////////////////////////////////////////////////////

module APB(
    // Outputs
    output reg [31:0] prdata,
    output reg pready,
    output reg perror,
    output reg [31:0] temp,

    // Inputs
    input pwrite,
    input [31:0] pwdata,
    input psel,
    input penable,
    input pclk,
    input preset,
    input [31:0] paddress
);

    // Internal Memory: 4 KB = 4096 entries of 32-bit (4 bytes each)
    reg [31:0] mem [0:4095];

    // Address decoding: using lower 12 bits (word-aligned)
    wire [11:0] mem_addr;
    assign mem_addr = paddress[13:2];  // 4-byte aligned word address

    // FSM states
    parameter [1:0] IDLE   = 2'b00,
                    SETUP  = 2'b01,
                    ACCESS = 2'b10;

    reg [1:0] present_state, next_state;

    // Sequential logic (Async)
    always @(posedge pclk or negedge preset) begin
        if (!preset)
            present_state <= IDLE;
        else
            present_state <= next_state;
    end

    // Combinational logic (next-state logic)
    always @(*) begin
        case (present_state)
            IDLE:   next_state = (psel && !penable) ? SETUP : IDLE;
            SETUP:  next_state = (psel && penable)  ? ACCESS : IDLE;
            ACCESS: next_state = (!psel) ? IDLE : ACCESS;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and memory read/write
    always @(posedge pclk or negedge preset) begin
        if (!preset) begin
            prdata <= 0;
            temp <= 0;
            pready <= 0;
            perror <= 0;
        end else begin
            pready <= 0;  

            case (present_state)
                ACCESS: begin
                    pready <= 1;

                    if (pwrite) begin
                        mem[mem_addr] <= pwdata;       
                        temp <= pwdata;
                        perror <= 0;
                    end else begin
                        prdata <= mem[mem_addr];        
                        temp <= mem[mem_addr];
                        perror <= 0;
                    end
                end

                default: begin
                    pready <= 0;
                end
            endcase
        end
    end

endmodule
