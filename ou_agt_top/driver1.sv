class driver1 extends uvm_driver#(trans);
  `uvm_component_utils(driver1)
  ou_agt_config ou_con;
  virtual jk_ff.RD_DRV vif;

  function new(string name = "driver1", uvm_component parent);  // ✅ fix 1
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(ou_agt_config)::get(this,"","ou_agt_config",ou_con))
      `uvm_fatal(get_type_name(), "DRIVER1 NOT FOUND")
    vif = ou_con.vif;
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done();
    end
  endtask

  task send_to_dut(trans req);        
    @(vif.rd_drv)
   vif.rd_drv.j <= req.j;  
  vif.rd_drv.k <= req.k;
  endtask

endclass