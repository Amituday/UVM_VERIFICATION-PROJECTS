class env extends uvm_env;
  `uvm_component_utils(env)

  agt_top    aa1;
  ou_agt_top o1;

  in_agt_config i1;
  ou_agt_config oo1;
  env_config    e1;

  scoreboard s1;

  function new(string name = "env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);                                    // ✅ fix 1

    aa1 = agt_top::type_id::create("aa1", this);
    o1  = ou_agt_top::type_id::create("o1", this);
    s1  = scoreboard::type_id::create("s1", this);

    if(!uvm_config_db#(env_config)::get(this,"","env_config",e1))
      `uvm_fatal("env", "not able to get the env_config")

    i1  = in_agt_config::type_id::create("i1");                 // ✅ fix 2
    oo1 = ou_agt_config::type_id::create("oo1");                // ✅ fix 2

    i1.vif  = e1.vif;
    oo1.vif = e1.vif;

    i1.is_active  = UVM_ACTIVE;
    uvm_config_db#(in_agt_config)::set(this,"*","in_agt_config",i1);  // ✅ fix 3, 4

    oo1.is_active = UVM_PASSIVE;
    uvm_config_db#(ou_agt_config)::set(this,"*","ou_agt_config",oo1); // ✅ fix 4

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    aa1.a1.m1.a_port.connect(s1.fifomh.analysis_export);
    o1.a1.m1.a1_port.connect(s1.fiforh.analysis_export);
  endfunction

endclass