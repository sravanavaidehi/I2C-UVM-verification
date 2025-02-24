class ag extends uvm_agent;
  `uvm_component_utils(ag);
  function new(string name = "ag", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  seqr seqr_h;
  dri dri_h;
  mon mon_h;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr_h = seqr::type_id::create("seqr_h",this);
    dri_h = dri::type_id::create("dri_h",this);
    mon_h = mon::type_id::create("mon_h",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    dri_h.seq_item_port.connect(seqr_h.seq_item_export);
  endfunction 
endclass

  
