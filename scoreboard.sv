class sc extends uvm_scoreboard;
  `uvm_component_utils(sc)
  function new(string name = "sc", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  uvm_analysis_imp #(item,sc) sc_ana;
  item it;
  bit [7:0] que[int];
 // bit [7:0] read = 0;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    it = item::type_id::create("it");
    sc_ana = new("sc_ana",this);
  endfunction
  
  function write(item it);
    if(it.rst) 
      `uvm_info("SC", "SYSTEM RESET DETECTED", UVM_NONE)
    else begin 
      if(it.wr) begin
        que[it.addr] = it.din;
        // $display("after que[%0d] = %d addr = %0d",it.addr,que[it.addr],it.addr);
        `uvm_info("SC", $sformatf("DATA WRITE OP  addr:%0d, din:%0d que:%0d",it.addr,it.din,  que[it.addr]), UVM_NONE)
      end
      else begin
       // $display("after que[%0d] = %d addr = %0d",it.addr,que[it.addr],it.addr);
        //read = que[it.addr];
       // $display("after dout = %0d",it.dout);
        if(que[it.addr] == it.dout)
          `uvm_info("SCO", $sformatf("DATA MATCHED : addr:%0d, rdata:%0d",it.addr,it.dout), UVM_NONE)
        else
          `uvm_info("SCO",$sformatf("TEST FAILED : addr:%0d, rdata:%0d data_rd_arr:%0d",it.addr,it.dout,read), UVM_NONE) 
      end
     end
          
    $display("----------------------------------------------------------------");
  endfunction
endclass
          
          
            
