`timescale 1ns / 1ps

module APB_tb;

    // Inputs
    reg pclk;
    reg preset;
    reg pwrite;
    reg psel;
    reg penable;
    reg [31:0] pwdata;
    reg [31:0] paddress;

    // Outputs
    wire [31:0] prdata;
    wire [31:0] temp;
    wire pready;
    wire perror;

    // Instantiate the APB module
    APB uut (
        .pclk(pclk),
        .preset(preset),
        .pwrite(pwrite),
        .psel(psel),
        .penable(penable),
        .pwdata(pwdata),
        .paddress(paddress),
        .prdata(prdata),
        .temp(temp),
        .pready(pready),
        .perror(perror)
    );

    // Clock generation
    always #5 pclk = ~pclk;  // 100MHz clock

    initial begin
        // Initialize
        pclk = 0;
        preset = 0;
        pwrite = 0;
        psel = 0;
        penable = 0;
        pwdata = 0;
        paddress = 0;

        // Apply reset
        #10 preset = 1;

        // ----------------------------
        // Write transaction
        // ----------------------------
        @(posedge pclk);
        pwrite = 1;
        psel = 1;
        penable = 0;
        paddress = 5;
        pwdata = 32'hDEADBEEF;

        @(posedge pclk);
        penable = 1;  // Move to ACCESS phase

        @(posedge pclk);
        penable = 0;
        psel = 0;

        // Wait for a cycle
        @(posedge pclk);

        // ----------------------------
        // Read transaction
        // ----------------------------
        @(posedge pclk);
        pwrite = 0;
        psel = 1;
        penable = 0;
        paddress = 5;

        @(posedge pclk);
        penable = 1;

        @(posedge pclk);
        penable = 0;
        psel = 0;

        // Wait and observe output
        @(posedge pclk);
        $display("Read Data from Address 5 = %h", prdata); // Expect DEADBEEF

        // Finish
        #20 $finish;
    end

endmodule
