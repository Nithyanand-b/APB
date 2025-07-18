module apb (

           input              PCLK,
           input           PRESETn,
           input              PSEL,
           input           PENABLE,
           input            PWRITE,
           input   [31:0]    PADDR,
           input   [31:0]   PWDATA,
          output reg [31:0]   PRDATA

           );

           reg [31:0] reg1;
           reg [31:0] reg2;
           reg [31:0] reg3;
           reg [31:0] reg4;

          always @(posedge PCLK or negedge PRESETn) 
          begin

               if (!PRESETn) 
               begin

                    reg1     <= 32'h0;
                    reg2     <= 32'h0;
                    reg3     <= 32'h0;
                    reg4     <= 32'h0;

               end

               else if (PSEL && PENABLE && PWRITE) 
               begin

                    case (PADDR)

                         'h0:  reg1     <= PWDATA;
                         'h4:  reg2     <= PWDATA;
                         'h8:  reg3     <= PWDATA;
                         'hC:  reg4     <= PWDATA;

                    endcase

               end

          end

          
          always_comb //always@ (*)
          begin

               if (PSEL && PENABLE && !PWRITE) 
               begin

                    case (PADDR)

                         'h0:  PRDATA   = reg1;
                         'h4:  PRDATA   = reg2;
                         'h8:  PRDATA   = reg3;
                         'hC:  PRDATA   = reg4;

                    default: PRDATA   = 32'h0;

                    endcase

               end

               else 
               begin
                    PRDATA = 32'h0;
               end

          end

endmodule
