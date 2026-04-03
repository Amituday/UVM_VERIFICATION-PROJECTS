class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
   
  uvm_analysis_port#(trans) a_port;
  virtual jk_ff.RD_MON vif;
  in_agt_config in_con;

  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
    a_port = new("a_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);           
    if(!uvm_config_db#(in_agt_config)::get(this,"","in_agt_config",in_con))
      `uvm_fatal("MON", "the sig in the monitor is not fetched")
       vif = in_con.vif;
  endfunction

  task run_phase(uvm_phase phase);
    trans t1;
    t1 = trans::type_id::create("t1");  
    forever begin
      @(vif.rd_mon)
      t1.j = vif.rd_mon.j;       
      t1.k = vif.rd_mon.k;
      a_port.write(t1);
    end
  endtask

endclass

     

  