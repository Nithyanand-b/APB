interface apb_if ();
 
    logic   [31 : 0]  PADDR;
    logic   [31 : 0]  PWDATA;
    logic   [31 : 0]  PRDATA;
    logic             PWRITE;
    logic             PSEL;
    logic             PENABLE;
    logic             PRESETn;
    logic             PCLK;
 
endinterface : apb_if