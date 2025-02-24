class mon extends uvm_monitor;
  `uvm_component_utils(mon);
  function new(string name = "mon", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual intf vif;
  uvm_analysis_port #(item) mon_ana;
  item it;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    it = item::type_id::create("it");
    mon_ana = new("mon_ana",this);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
      `uvm_fatal("MONITER","unable to access interface")
  endfunction 
      
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
    @(posedge vif.clk)
    if(vif.rst) begin
      `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
      mon_ana.write(it);
    end
    
    else begin 
      
      if(vif.wr) begin
        it.wr <= vif.wr;
        it.din <= vif.din;
        it.addr <= vif.addr;
        @(posedge vif.done);
        `uvm_info("MON", $sformatf("DATA WRITE addr:%0d data:%0d",it.addr,it.din), UVM_NONE); 
        mon_ana.write(it);
      end
      else begin
        it.wr <= vif.wr;
        it.addr <= vif.addr;
        it.din <= vif.din;
        @(posedge vif.done);
        it.dout = vif.dout;
        `uvm_info("MON", $sformatf("DATA READ addr:%0d dout:%0d ",it.addr,it.dout), UVM_NONE); 
        mon_ana.write(it);
      end
    end
    end
 endtask
endclass
  
