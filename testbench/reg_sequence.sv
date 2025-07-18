class reg1_wr extends uvm_sequence;
 
  `uvm_object_utils(reg1_wr)
  
   reg_block reg_model;
  
   
  function new (string name = "reg1_wr"); 
    super.new(name);    
  endfunction
  
 
  task body;  
    uvm_status_e   status;
    bit [31:0] wdata; 
    
    //////working with control 
    for(int i = 0; i < 5 ; i++) begin
       wdata = $urandom_range(0,9);
       reg_model.reg1_1.write(status, wdata);
    end
    
  endtask
  
  
endclass
  
/////////////////////////////////////////////////////////////////////////
 //////////////////read data from control reg     
        
       
 class reg1_rd extends uvm_sequence;
 
  `uvm_object_utils(reg1_rd)
  
   reg_block reg_model;
  
   
  function new (string name = "reg1_rd"); 
    super.new(name);    
  endfunction
  
 
  task body;  
    uvm_status_e   status;
    bit [31:0] rdata;
    
    //////working with control 
    for(int i = 0; i < 5 ; i++) begin
     reg_model.reg1_1.read(status, rdata); 
    end
    
 
 
  endtask
  
  
  
endclass        
                  
///////////////////////////////////////////////////////////////         
         
  /////////////////////////////////////////////////
 //////////////////write data to reg2 reg     
      
 class reg2_wr extends uvm_sequence;
 
  `uvm_object_utils(reg2_wr)
  
   reg_block reg_model;
  
   
  function new (string name = "reg2_wr"); 
    super.new(name);    
  endfunction
  
 
  task body;  
    uvm_status_e   status;
    bit [31:0] wdata; 
    
    //////working with control 
    for(int i = 0; i < 5 ; i++) begin
       wdata = $urandom_range(0,9);
       reg_model.reg2_2.write(status, wdata);
    end
    
  endtask
  
  
endclass
  
/////////////////////////////////////////////////////////////////////////
 //////////////////read data from control reg     
        
       
 class reg2_rd extends uvm_sequence;
 
  `uvm_object_utils(reg2_rd)
  
   reg_block reg_model;
  
   
  function new (string name = "reg2_rd"); 
    super.new(name);    
  endfunction
  
 
  task body;  
    uvm_status_e   status;
    bit [31:0] rdata;
    
    //////working with control 
    for(int i = 0; i < 5 ; i++) begin
     reg_model.reg2_2.read(status, rdata); 
    end
    
 
 
  endtask
  
  
  
endclass           


class reg3_wr extends uvm_sequence;
 
  `uvm_object_utils(reg3_wr)
  
   reg_block reg_model;
  
   
  function new (string name = "reg3_wr"); 
    super.new(name);    
  endfunction
  
 
  task body;  
    uvm_status_e   status;
    bit [31:0] wdata; 
    
    //////working with control 
    for(int i = 0; i < 5 ; i++) begin
       wdata = $urandom_range(0,9);
       reg_model.reg3_3.write(status, wdata);
    end
    
  endtask
  
  
endclass
  

 class reg3_rd extends uvm_sequence;
 
  `uvm_object_utils(reg3_rd)
  
   reg_block reg_model;
  
   
  function new (string name = "reg3_rd"); 
    super.new(name);    
  endfunction
  
 
  task body;  
    uvm_status_e   status;
    bit [31:0] rdata;
    
    //////working with control 
    for(int i = 0; i < 5 ; i++) begin
     reg_model.reg3_3.read(status, rdata); 
    end
    
 
 
  endtask
  
  
  
endclass           
