class agt_top extends uvm_component; 
 
   `uvm_component_utils(agt_top)
     agent a1; 
   function new(string name ="agt_top" ,uvm_component parent);
    super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     a1=agent ::type_id::create("a1",this);

     endfunction 



endclass 