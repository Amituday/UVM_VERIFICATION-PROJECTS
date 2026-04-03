class ou_agt_top extends uvm_component;
  `uvm_component_utils(ou_agt_top)

  agent1 a1;

  function new(string name = "ou_agt_top", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a1 = agent1::type_id::create("a1", this);   // ✅ string arg + semicolon
  endfunction

endclass