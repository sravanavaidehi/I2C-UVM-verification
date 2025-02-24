//--------------------------------reset seq-----------------------


class seq_rst extends uvm_sequence#(item);
  `uvm_object_utils(seq_rst)
  
  function new(string name = "seq_rst");
    super.new(name);
  endfunction
  
  item it; 
  task body();
    
    repeat(5) begin
      it = item::type_id::create("it");
      start_item(it);
      it.randomize() with{(it.rst == 1);};
      `uvm_info("SEQ", "MODE : RESET", UVM_NONE)
      finish_item(it);
    end 
  endtask
endclass

//--------------------------write seq---------------------------

class seq_wr extends uvm_sequence#(item);
  `uvm_object_utils(seq_wr)
  
  function new(string name = "seq_wr");
    super.new(name);
  endfunction
  
  item it; 
  task body();
    
    repeat(15) begin
      it = item::type_id::create("it");
      start_item(it);
      it.randomize() with{(it.wr == 1) && (it.rst == 0);};
      `uvm_info("SEQ", "MODE : WRITE", UVM_NONE)
      finish_item(it);
    end 
  endtask
endclass

//--------------------------read seq-----------------------------

class seq_rd extends uvm_sequence#(item);
  `uvm_object_utils(seq_rd)
  
  function new(string name = "seq_rd");
    super.new(name);
  endfunction
  
  item it; 
  task body();
    
    repeat(15) begin
      it = item::type_id::create("it");
      start_item(it);
      it.randomize() with{(it.wr == 0) && (it.rst == 0);};
      `uvm_info("SEQ", "MODE : READ", UVM_NONE)
      finish_item(it);
    end 
  endtask
endclass
