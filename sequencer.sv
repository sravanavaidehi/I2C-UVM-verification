//--------------------------sequencer---------------------------

class seqr extends uvm_sequencer#(item);
  `uvm_component_utils(seqr)
  
  function new(string name = "seqr", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass
