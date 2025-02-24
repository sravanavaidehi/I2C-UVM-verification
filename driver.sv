class dri extends uvm_driver#(item);
  `uvm_component_utils(dri)
  
  function new(string name = "dri", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  item it;
  virtual intf vif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    it = item::type_id::create("it");
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    `uvm_fatal("DRIVER","unable to access interface")
  endfunction 
      
  virtual task  run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin 
      seq_item_port.get_next_item(it);
      if(it.rst == 1) reset(it);
      else if(it.wr  == 1) write(it);
      else if(it.wr == 0)  read(it);
      seq_item_port.item_done();
    end
    endtask
    
    task reset(item it);
      `uvm_info("DRV", "System Reset", UVM_MEDIUM);
      vif.rst <= 1;
      vif.wr <= 0;
      vif.din <= 0 ;
      vif.addr <= 0;
      
      @(posedge vif.clk);
    endtask
    
    task write(item it);
      vif.rst <= 0;
      vif.wr <= it.wr;
      vif.din <= it.din;
      vif.addr <= it.addr;
      `uvm_info("DRV", $sformatf("mode :rst = %0d WRITE wr= %0d addr : %0d  din : %0d", it.rst,it.wr, it.addr, it.din), UVM_NONE);
      //$display("waitig for done");
      @(posedge vif.done);
      
      //$display(" done");
    endtask 
    
    task read(item it);
     
      vif.rst <= 0;
      vif.wr <= it.wr;
      vif.din <= 0;
      vif.addr <= it.addr;
      @(posedge vif.done);
      `uvm_info("DRV", $sformatf("mode : READ rst = %0d wr= %0d addr : %0d  din : %0d",it.rst, it.wr, it.addr, vif.din), UVM_NONE);
    endtask 
    
    endclass
    
