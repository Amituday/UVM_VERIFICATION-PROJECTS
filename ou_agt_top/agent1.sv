class agent1 extends uvm_agent;
  `uvm_component_utils(agent1)

  driver1    d1;
  monitor1   m1;
  sequencer1 s1;
  ou_agt_config ou_con;

  function new(string name = "agent1", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);                                       

    if(!uvm_config_db#(ou_agt_config)::get(this,"","ou_agt_config",ou_con))  
      `uvm_fatal(get_type_name(), "the config failed to get")

    m1 = monitor1::type_id::create("m1", this);                    

    if(ou_con.is_active == UVM_ACTIVE) begin
      d1 = driver1::type_id::create("d1", this);
      s1 = sequencer1::type_id::create("s1", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(ou_con.is_active == UVM_ACTIVE) begin
      d1.seq_item_port.connect(s1.seq_item_export);
    end
  endfunction

endclass