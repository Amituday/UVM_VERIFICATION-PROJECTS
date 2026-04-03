class test extends uvm_test;
  `uvm_component_utils(test)          // ✅ fix 1

  env        e1;
  env_config e_con;
  virtual jk_ff vif;
  seq        s1;

  function new(string name = "test", uvm_component parent);  // ✅ fix 2
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);                                 // ✅ fix 4 — always first

    e_con = env_config::type_id::create("e_con");

    if(!uvm_config_db#(virtual jk_ff)::get(this,"","vif",vif))  // ✅ fix 3
      `uvm_fatal("test", "not able to retrieve vif")

    e_con.vif = vif;                                          // ✅ fix 4 — assign before set

    uvm_config_db#(env_config)::set(this,"*","env_config",e_con);  // ✅ fix 4 — semicolon

    e1 = env::type_id::create("e1", this);                   // ✅ fix 4 — create after set

  endfunction

function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    phase.raise_objection(this);    
    s1 = seq::type_id::create("s1");                          // ✅ fix 6
    s1.start(e1.aa1.a1.s1);
    phase.drop_objection(this);                               // ✅ fix 6
  endtask

endclass