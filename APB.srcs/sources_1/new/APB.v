`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// Module Name: APB
// Description: APB (Advanced Peripheral Bus) protocol implementation
//////////////////////////////////////////////////////////////////////////////////

module APB(
    // ..Outputs
    output reg [31:0] prdata,
    output reg pready,
    output reg perror,
    output reg [31:0] temp,

    // ..Inputs
    input pwrite,
    input [31:0] pwdata,
    input psel,
    input penable,
    input pclk,
    input preset,
    input [31:0] paddress
);

    // Mem
    reg [31:0] mem [0:31];

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

    // Combinational logic: next-state logic
    always @(*) begin
    
        case (present_state)
        
                    IDLE: begin
                        if (psel && !penable)
                            next_state = SETUP;
                        else
                            next_state = IDLE;
                    end
                    
                    SETUP: begin
                        if (psel && penable)
                            next_state = ACCESS;
                        else
                            next_state = IDLE;
                    end

                    ACCESS: begin
                          if (!psel)
                              next_state = IDLE;
                          else
                              next_state = ACCESS;
                    end

  
            default: next_state = IDLE;
 
       endcase
    end

    // Output logic and memory access
    always @(posedge pclk or negedge preset) begin
        if (!preset) begin
            prdata <= 0;
            temp <= 0;
            pready <= 0;
            perror <= 0;
        end else begin
            pready <= 0; // Default value

            case (present_state)
                ACCESS: begin
                    pready <= 1;

                    if (pwrite) begin
                        mem[paddress] <= pwdata;
                        temp <= pwdata;
                        perror <= 0;
                    end else begin
                        prdata <= mem[paddress];
                        temp <= mem[paddress];
                        perror <= 0;
                    end
                end

                default: begin
                    // Hold outputs or assign default values
                    pready <= 0;
                end
            endcase
        end
    end

endmodule
