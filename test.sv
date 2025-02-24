
class test extends uvm_test;
  `uvm_component_utils(test)
  function new(string name = "test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  env e_h;
  seq_rst seq_rst_h;
  seq_wr seq_wr_h;
  seq_rd seq_rd_h;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e_h = env::type_id::create("e_h",this);
    seq_rst_h = seq_rst::type_id::create("seq_rst_h");
    seq_wr_h = seq_wr::type_id::create("seq_wr_h");
    seq_rd_h = seq_rd::type_id::create("seq_rd_h");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq_rst_h.start(e_h.ag_h.seqr_h);
   // #20
    seq_wr_h.start(e_h.ag_h.seqr_h);
    //#20
    seq_rd_h.start(e_h.ag_h.seqr_h);
   // #20
    phase.drop_objection(this);
  endtask
endclass

    
  
