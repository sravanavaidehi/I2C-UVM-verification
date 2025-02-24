//typedef enum {reset = 0,write,read} mode;

class item extends uvm_sequence_item;
  `uvm_object_utils(item)
  
  function new(string name = "item");
    super.new(name);
  endfunction
  
 // rand mode mode_h;
  rand bit rst;
  rand bit wr;
  randc bit [6:0] addr;
  rand bit [7:0] din;
  bit [7:0] dout;
  bit done;
  
  constraint addr_c { addr < 10 ;}
endclass
