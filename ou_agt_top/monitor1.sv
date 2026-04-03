class monitor1 extends uvm_monitor;
  `uvm_component_utils(monitor1)            
  uvm_analysis_port#(trans) a1_port;
  virtual jk_ff.WR_MON vif;
  ou_agt_config ou_con;

  function new(string name = "monitor1", uvm_component parent);  
    super.new(name,parent);
    a1_port = new("a1_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);                                     
    if(!uvm_config_db#(ou_agt_config)::get(this,"","ou_agt_config",ou_con))  
      `uvm_fatal("MON1", "the sig in the monitor1 is not fetched")
    vif = ou_con.vif;
  endfunction

  task run_phase(uvm_phase phase);
    trans t1;
    t1 = trans::type_id::create("t1");
    forever begin
      @(vif.wr_mon)
      t1.q = vif.wr_mon.q; 
      a1_port.write(t1);                                       
    end
  endtask

endclass