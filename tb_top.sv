`include "uvm_macros.svh"

`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "sc.sv"
`include "test.sv"
     

module tb;
  
  import uvm_pkg::*;
  
  intf vif();
  i2c_mem m1(.clk(vif.clk),.rst(vif.rst),.wr(vif.wr),.addr(vif.addr), .din(vif.din), .datard(vif.dout), .done(vif.done));
  
  initial vif.clk = 1;
  always #5 vif.clk = ~vif.clk;
  
  initial begin
    
    uvm_config_db #(virtual intf) :: set(null,"*","vif",vif);
    run_test("test");
    #1000 $finish;
  end
  
   initial begin 
    $dumpfile("dumb.vcd");
   $dumpvars;
  end
  
endmodule
  
