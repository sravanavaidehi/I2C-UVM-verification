class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name = "env", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  sc sc_h;
  ag ag_h;
  
   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     sc_h = sc::type_id::create("sc_h",this);
     ag_h = ag::type_id::create("ag_h",this);
  endfunction
  
   virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     ag_h.mon_h.mon_ana.connect(sc_h.sc_ana);
  endfunction 
endclass
